module Cryptoexchange::Exchanges
  module Ddex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ddex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data']['markets'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['baseAsset'],
              target: pair['quoteAsset'],
              market: Ddex::Market::NAME
            )
          end
        end
      end
    end
  end
end
