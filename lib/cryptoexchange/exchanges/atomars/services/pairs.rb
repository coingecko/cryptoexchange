module Cryptoexchange::Exchanges
  module Atomars
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Atomars::Market::API_URL}/symbols"


        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base'],
                              target: pair['quote'],
                              market: Atomars::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
