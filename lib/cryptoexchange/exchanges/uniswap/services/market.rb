module Cryptoexchange::Exchanges
  module Uniswap
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        HOURS_24 = (24*60*60).to_f
        HOURS_48 = 48*60*60

        def fetch(market_pair)
          response = TheGraphClient::Client.query(TheGraphClient::TokenDayDataQuery, variables: { token: market_pair.base_raw, range_timestamp: Time.now.to_i - HOURS_48 })
          if response.data.token_day_datas.any?
            token_day_data_current = response.data.token_day_datas.first
            token_day_data_previous = response.data.token_day_datas.last
            volume = token_day_data_current.daily_volume_token.to_f
            volume = volume + (token_day_data_previous.daily_volume_token.to_f * ( HOURS_24 - ((Time.now.to_i - HOURS_24) - token_day_data_previous.date)) / HOURS_24 )
            adapt(token_day_data_current.token.derived_eth, market_pair, token_day_data_current.daily_volume_token)
          end
        end

        def adapt(last_price, market_pair, volume)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base_raw
          ticker.target    = market_pair.target_raw
          ticker.market    = Uniswap::Market::NAME
          ticker.last      = last_price.to_f
          ticker.volume    = volume.to_f
          ticker.timestamp = nil
          ticker.payload   = { last_price: last_price, volume: volume }
          ticker
        end
      end
    end
  end
end
