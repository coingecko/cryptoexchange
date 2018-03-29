module Cryptoexchange::Exchanges
  module CoinEgg
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: CoinEgg::Market::NAME
                            )
          end

          market_pairs
        end

      end
    end
  end
end
