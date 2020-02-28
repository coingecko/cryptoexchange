module Cryptoexchange::Exchanges
  module Currency
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Currency::Market::API_URL}/api/v1/token_crypto/ticker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            market_pair = Cryptoexchange::Models::MarketPair.new({
              base: ticker['base_currency'],
              target: ticker['quote_currency'],
              market: Currency::Market::NAME
            })
            adapt(market_pair, ticker)
          end.compact
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Currency::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['lowest_ask_price'])
          ticker.bid       = NumericHelper.to_d(output['highest_bid_price'])
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.high      = NumericHelper.to_d(output['past_24hrs_high_price'])
          ticker.low       = NumericHelper.to_d(output['past_24hrs_low_price'])
          ticker.change    = NumericHelper.to_d(output['past_24hrs_price_change'].to_f)
          ticker.volume    = NumericHelper.to_d(output['base_volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
