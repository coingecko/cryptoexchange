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
          output["data"].map do |pair|
            target, base = pair[0].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitmesh::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitmesh::Market::NAME
          ticker.last      = NumericHelper.to_d(output[1]['price'])
          ticker.high      = NumericHelper.to_d(output[1]['max'])
          ticker.low       = NumericHelper.to_d(output[1]['min'])
          ticker.volume    = output[1]['volume'] ? NumericHelper.to_d(output[1]['volume']) : 0
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
