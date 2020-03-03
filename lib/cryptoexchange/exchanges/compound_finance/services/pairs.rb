module Cryptoexchange::Exchanges
  module CompoundFinance
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CompoundFinance::Market::API_URL}/ctoken?meta=false"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["cToken"].map do |pair|
            base = pair["symbol"]
            target = pair["underlying_symbol"]

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: CompoundFinance::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
