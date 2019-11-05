module Cryptoexchange::Exchanges
  module Elitex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Elitex::Market::API_URL}/public/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |pair|
            base, target = pair["code"].split("_")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Elitex::Market::NAME
            )
          end
        end
      end
    end
  end
end
