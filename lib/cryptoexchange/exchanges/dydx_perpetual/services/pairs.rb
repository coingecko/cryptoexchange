module Cryptoexchange::Exchanges
  module DydxPerpetual
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::DydxPerpetual::Market::API_URL}/stats/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do |pair, value|
            next if value["type"] != "PERPETUAL"

            base, target = pair.split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              inst_id: value["symbol"],
              contract_interval: "perpetual",
              market: DydxPerpetual::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
