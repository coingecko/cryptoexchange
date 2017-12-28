module Cryptoexchange::Exchanges
  module Lykke
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        TARGETS_URL = "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/AssetPairs/dictionary"

        def fetch
          pairs_output = HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(TARGETS_URL)
          pairs_dictionary = JSON.parse(pairs_output.to_s)
          adapt(pairs_dictionary)
        end

        def adapt(pairs_dictionary)
          market_pairs = []
          pairs_dictionary.each do |pair|
            base = pair["baseAssetId"]
            target = pair["quotingAssetId"]
            next unless base && target
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Lykke::Market::NAME
                            )

          end
          market_pairs
        end
      end
    end
  end
end
