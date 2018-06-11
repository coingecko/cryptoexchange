module Cryptoexchange::Exchanges
  module Bilaxy
    module Services
      class Pairs < Cryptoexchange::Services::Pairs

        def fetch
          output = super
          output.map do |pair|
            Cryptoexchange::Models::Bilaxy::MarketPair.new(
              base:   pair[:base],
              target: pair[:target],
              id:     pair[:id],
              market: Bilaxy::Market::NAME
            )
          end
        end
      end
    end
  end
end
