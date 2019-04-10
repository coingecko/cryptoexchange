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
                              base: symbol_from_assets(pair['base']),
                              target: symbol_from_assets(pair['quote']),
                              market: Kraken::Market::NAME
                            )
          end

          market_pairs
        end

        private

        # Custom to Kraken
        ASSETS_URL = "#{Cryptoexchange::Exchanges::Kraken::Market::API_URL}/Assets"

        def assets
          fetch_response = HTTP.timeout(15).get(self.class::ASSETS_URL)
          JSON.parse(fetch_response.to_s)['result']
        end

        def symbol_from_assets(kraken_symbol)
          assets[kraken_symbol]['altname']
        end
      end
    end
  end
end
