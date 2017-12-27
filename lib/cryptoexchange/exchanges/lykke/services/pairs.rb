module Cryptoexchange::Exchanges
  module Lykke
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/AssetPairs/rate"
        TARGETS_URL = "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/AssetPairs/dictionary"


        def fetch
          output = super
          pairs_output = HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(TARGETS_URL)
          @pairs_dictionary = JSON.parse(pairs_output.to_s)
          adapt(output, @pairs_dictionary)
        end

        def adapt(output, pairs_dictionary)
          market_pairs = []
          output.each do |pair|
            pair_object = @pairs_dictionary.select{ |pairs| pairs["id"] == pair["id"] }
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
      end
    end
  end
end
