module Cryptoexchange::Exchanges
  module Bitstamp
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Bitstamp::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: Bitstamp::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
