require 'pry'
module Cryptoexchange::Exchanges
  module Bitmesh
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bitmesh::Market::API_URL}"
        end

        def adapt_all(output)
          output["data"].map do |pair, value|
            target, base = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitmesh::Market::NAME
            )
            adapt(value, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitmesh::Market::NAME
          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.high      = NumericHelper.to_d(output['max'])
          ticker.low       = NumericHelper.to_d(output['min'])
          ticker.volume    = output['volume'] ? NumericHelper.to_d(output['volume']) : 0
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
