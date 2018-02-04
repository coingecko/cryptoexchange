module Cryptoexchange::Exchanges
  module Bigone
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bigone::Market::API_URL}/markets"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base'],
                              target: pair['quote'],
                              market: Bigone::Market::NAME
                            )
          end
          market_pairs
        end

      end
    end
  end
end
