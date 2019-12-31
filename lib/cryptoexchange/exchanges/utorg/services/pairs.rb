module Cryptoexchange::Exchanges
  module Utorg
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Utorg::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["elements"].map do |pair|
            next if pair["disabled"] == true

            base = pair["baseCurrencyCode"]
            target = pair["quoteCurrencyCode"]
            inst_id = pair["id"]
            next unless base && target

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              inst_id: inst_id,
              market: Utorg::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
