module Cryptoexchange::Exchanges
  module Escodex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Escodex::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['quote'],
                              target: pair['base'],
                              market: Escodex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
