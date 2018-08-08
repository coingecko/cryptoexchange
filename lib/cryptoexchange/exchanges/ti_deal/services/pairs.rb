module Cryptoexchange::Exchanges
  module TiDeal
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
              market: TiDeal::Market::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
