module Cryptoexchange::Exchanges
  module Coinmex
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
          "#{Cryptoexchange::Exchanges::Coinmex::Market::API_URL}/spot/public/products/#{market_pair.base}_#{market_pair.target}/ticker"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinmex::Market::NAME
          ticker.high       = NumericHelper.to_d(output[1])
          ticker.low       = NumericHelper.to_d(output[2])
          ticker.last      = NumericHelper.to_d(output[3])
          ticker.volume    = NumericHelper.to_d(output[4])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
