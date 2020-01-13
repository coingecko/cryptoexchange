module Cryptoexchange::Exchanges
  module Bitrabbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        # https://bitrabbit.io/api/v2/markets
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitrabbit::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |ticker|
            base, target = ticker["name"].split("/")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitrabbit::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
