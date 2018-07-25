module Cryptoexchange::Exchanges
  module Btcmarkets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "https://www.btcmarkets.net/data/market/active"

        def fetch
          output = super
          market_pairs = []
          output['markets'].each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['instrument'],
                              target: pair['currency'],
                              market: Btcmarkets::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
