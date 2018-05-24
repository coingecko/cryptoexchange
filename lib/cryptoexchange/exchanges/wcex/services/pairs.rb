module Cryptoexchange::Exchanges
  module Wcex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Wcex::Market::API_URL}/products"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair|
            base, target = pair.split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Wcex::Market::NAME
            )
          end
        end
      end
    end
  end
end
