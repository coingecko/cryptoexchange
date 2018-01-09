module Cryptoexchange::Exchanges
  module Lykke
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
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
                              base: base,
                              target: target,
                              market: Lykke::Market::NAME
                            )

          end
        end
      end
    end
  end
end
