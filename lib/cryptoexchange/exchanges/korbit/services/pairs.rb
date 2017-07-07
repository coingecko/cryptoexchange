module Cryptoexchange::Exchanges
  module Korbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        MARKET = Korbit::Market

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Korbit::Models::MarketPair.new(
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
