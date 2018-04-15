module Cryptoexchange::Exchanges
  module Zebpay
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: Zebpay::Market::NAME
                            )
          end
          market_pairs
        end

      end
    end
  end
end
