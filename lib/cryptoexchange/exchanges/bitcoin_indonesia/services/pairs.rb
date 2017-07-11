module Cryptoexchange::Exchanges
  module BitcoinIndonesia
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        MARKET = BitcoinIndonesia::Market

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << BitcoinIndonesia::Models::MarketPair.new(
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
