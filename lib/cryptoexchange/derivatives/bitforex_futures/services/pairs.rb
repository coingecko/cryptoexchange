module Cryptoexchange::Exchanges
  module BitforexFutures
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
              market: BitforexFutures::Market::NAME
            )
          end
        end
      end
    end
  end
end
