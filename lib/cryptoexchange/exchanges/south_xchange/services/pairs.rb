module Cryptoexchange::Exchanges
  module SouthXchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::SouthXchange::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair[0],
              target: pair[1],
              market: SouthXchange::Market::NAME
            )
          end
        end
      end
    end
  end
end
