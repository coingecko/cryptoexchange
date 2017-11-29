module Cryptoexchange::Exchanges
  module Acx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Acx::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
            output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base_unit'],
                              target: pair['quote_unit'],
                              market: Acx::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
