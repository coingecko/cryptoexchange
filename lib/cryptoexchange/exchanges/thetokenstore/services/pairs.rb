module Cryptoexchange::Exchanges
  module Thetokenstore
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Thetokenstore::Market::API_URL}/pairs"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['toSymbol'],
                              target: pair['fromSymbol'],
                              market: Thetokenstore::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
