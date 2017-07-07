module Cryptoexchange::Exchanges
  module Coincheck
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        MARKET = Coincheck::Market

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Coincheck::Models::MarketPair.new(
              base: pair[:base],
              target: pair[:target],
              market: MARKET::NAME
            )
          end
          market_pairs
        end
      end
    end
  end
end
