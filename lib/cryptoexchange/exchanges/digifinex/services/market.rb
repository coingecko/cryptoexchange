module Cryptoexchange::Exchanges
  module Digifinex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          pair = "#{market_pair.base}_#{ market_pair.target}"
          "#{Cryptoexchange::Exchanges::Digifinex::Market::API_URL}/ticker?market=digifinex&symbol_pair=#{pair}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Digifinex::Market::NAME

          ticker.last      = NumericHelper.to_d(output['data']['last'])
          ticker.high      = NumericHelper.to_d(output['data']['high'])
          ticker.low       = NumericHelper.to_d(output['data']['low'])
          ticker.bid       = NumericHelper.to_d(output['data']['bid'])
          ticker.ask       = NumericHelper.to_d(output['data']['ask'])
          ticker.volume    = NumericHelper.to_d(output['data']['base_volume'])
          ticker.change    = NumericHelper.to_d(output['data']['change_daily'])

          ticker.timestamp = output['data']['timestamps'].to_i / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
