module Cryptoexchange::Exchanges
  module Kraken
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Kraken::Market::API_URL}/AssetPairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['result'].each do |key, pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base'],
                              target: pair['quote'],
                              market: Kraken::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
