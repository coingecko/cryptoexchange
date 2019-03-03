require 'pry'
module Cryptoexchange::Exchanges
  module Belfrics
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          binding.pry
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: Belfrics::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
