module Cryptoexchange::Exchanges
  module Dydx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Dydx::Market::API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do |pair|
            base, target = pair[0].split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Dydx::Market::NAME
            )
          end
        end
      end
    end
  end
end
