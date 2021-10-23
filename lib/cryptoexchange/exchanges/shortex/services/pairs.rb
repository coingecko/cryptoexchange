module Cryptoexchange::Exchanges
  module Shortex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Shortex::Market::API_URL}/public/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair["name"].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Shortex::Market::NAME,
            )
          end
        end
      end
    end
  end
end
