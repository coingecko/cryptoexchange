module Cryptoexchange::Exchanges
  module Bit2c
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: Bit2c::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
