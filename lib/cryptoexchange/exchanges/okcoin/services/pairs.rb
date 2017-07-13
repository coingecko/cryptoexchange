module Cryptoexchange::Exchanges
  module Okcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Okcoin::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: Okcoin::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
