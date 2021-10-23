module Cryptoexchange::Exchanges
  module Nominex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super ticker_url(market_pair)
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Nominex::Market::API_URL}/ticker/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Nominex::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.volume    = NumericHelper.to_d(output['quoteVolume']) / ticker.last
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.change    = NumericHelper.to_d(output['dailyChangeP'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
