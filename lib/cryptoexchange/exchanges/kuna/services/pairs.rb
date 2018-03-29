module Cryptoexchange::Exchanges
  module Kuna
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          adapt(super)
        end

        def adapt(output)
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair[:base],
              target: pair[:target],
              market: Kuna::Market::NAME
            )
          end
        end
      end
    end
  end
end
