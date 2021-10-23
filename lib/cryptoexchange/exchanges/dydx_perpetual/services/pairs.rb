module Cryptoexchange::Exchanges
  module DydxPerpetual
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::DydxPerpetual::Market::API_URL}/stats/markets"

        def fetch
          output = super
          adapt(output)
        end

        def get_base(base)
          if base == "PBTC"
            return "BTC"
          end

          base
        end

        def adapt(output)
          output['markets'].map do |pair, value|
            next if value["type"] != "PERPETUAL"

            base, target = pair.split("-")
            converted_base = get_base(base)
            Cryptoexchange::Models::MarketPair.new(
              base:   converted_base,
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
