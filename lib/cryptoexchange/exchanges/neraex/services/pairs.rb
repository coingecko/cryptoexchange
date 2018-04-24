module Cryptoexchange::Exchanges
  module Neraex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Neraex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []

          output.each do |pair|
            base, target = pair["name"].split("/")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Neraex::Market::NAME
            )

            market_pairs << market_pair
          end

          market_pairs
        end
      end
    end
  end
end
