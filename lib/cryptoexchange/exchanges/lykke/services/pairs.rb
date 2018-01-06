module Cryptoexchange::Exchanges
  module Lykke
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
<<<<<<< HEAD
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
=======
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Lykke::Market::API_URL}/AssetPairs/dictionary"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base = pair["baseAssetId"]
            target = pair["quotingAssetId"]
            Cryptoexchange::Models::MarketPair.new(
>>>>>>> upstream/master
                              base: base,
                              target: target,
                              market: Lykke::Market::NAME
                            )
<<<<<<< HEAD
          end
          market_pairs
=======

          end
>>>>>>> upstream/master
        end
      end
    end
  end
end
