module Cryptoexchange::Exchanges
  module Btcsquare
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Btcsquare::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            target, base = pair.keys.first.split('-')

            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Btcsquare::Market::NAME
            )
          end
        end
      end
    end
  end
end
