module Cryptoexchange::Exchanges
  module Freiexchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Freiexchange::Market::API_URL}/returnTicker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, output|
             base, target = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Freiexchange::Market::NAME
            )
          end
        end
      end
    end
  end
end
