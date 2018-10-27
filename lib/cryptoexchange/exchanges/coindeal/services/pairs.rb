module Cryptoexchange::Exchanges
  module Coindeal
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://europe1.coindeal.com/api/v1/markets/list"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['baseCurrency'],
                              target: pair['quoteCurrency'],
                              market: Coindeal::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
