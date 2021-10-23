module Cryptoexchange::Exchanges
  module Dydx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dydx::Market::API_URL}/stats/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do |pair, value|
            next if value["type"] == "PERPETUAL"

            base, target = pair.split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Dydx::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
