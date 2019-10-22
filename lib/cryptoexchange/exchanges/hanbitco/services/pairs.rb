module Cryptoexchange::Exchanges
  module Hanbitco
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://resource.hanbitco.com/market_currency.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['markets'].map do |pair|
            base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Hanbitco::Market::NAME
            )
          end
        end
      end
    end
  end
end
