module Cryptoexchange::Exchanges
  module Cryptex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def fetch
          output = super
          output.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair[:base],
              target: pair[:target],
              market: Cryptex::Market::NAME
            )
          end
        end
      end
    end
  end
end
