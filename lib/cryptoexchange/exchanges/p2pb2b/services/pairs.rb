module Cryptoexchange::Exchanges
  module P2pb2b
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          response = super
          adapt(response)
        end

        def adapt(response)
          market_pairs = []
          response.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base: pair[:base],
              target: pair[:target],
              market: P2pb2b::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
