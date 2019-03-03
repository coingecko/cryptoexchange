require 'pry'
module Cryptoexchange::Exchanges
  module Belfrics
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(Belfrics::Market::API_URL)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Belfrics::Market::API_URL}"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   pair[:base],
              target: pair[:target],
              market: Belfrics::Market::NAME
            )
            binding.pry
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Belfrics::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['highsale'])
          ticker.low       = NumericHelper.to_d(output['lowsale'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume']) / ticker.last
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
