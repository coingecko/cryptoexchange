module Cryptoexchange::Exchanges
  module StellarTerm
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::StellarTerm::Market::API_URL}/ticker.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)

          output["assets"].map do |asset|
            next if asset["id"] == "XLM-native"

            base_raw = asset["id"]
            base = asset["code"]
            target = "XLM"

            Cryptoexchange::Models::MarketPair.new(
              base_raw: base_raw,
              base: base,
              target: target,
              market: StellarTerm::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
