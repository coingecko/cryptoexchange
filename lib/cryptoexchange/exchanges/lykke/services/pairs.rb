module Cryptoexchange::Exchanges
  module Lykke
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/AssetPairs/rate"
        TARGETS_URL = "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/AssetPairs/dictionary"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            pair_object = get_pair(pair["id"])
            base = pair_object[0]["baseAssetId"]
            target = pair_object[0]["quotingAssetId"]
            next unless base && target
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Lykke::Market::NAME
                            )
          end
          market_pairs
        end

        def get_pair(pair)
          pairs_output = HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(TARGETS_URL)
          pairs_parsed = JSON.parse(pairs_output.to_s)
          pair_object = pairs_parsed.select{ |pairs| pairs["id"] == pair }
        end
      end
    end
  end
end
