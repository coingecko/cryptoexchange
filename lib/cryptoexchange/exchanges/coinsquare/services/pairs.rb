module Cryptoexchange::Exchanges
  module Coinsquare
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://coinsquare.com/api/v1/data/quotes"

        def fetch
          output = super
          market_pairs = []
          output['quotes'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['ticker'],
                              target: pair['base'],
                              market: Coinsquare::Market::NAME
                            )
           end
          market_pairs
        end
      end
    end
  end
end
