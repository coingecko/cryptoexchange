module Cryptoexchange::Exchanges
  module Ercdex
    module Services
      class IdFetcher

        PAIR_SYMBOLS_URL = "#{Cryptoexchange::Exchanges::Ercdex::Market::API_URL}/token-pair-summaries/1"
        PAIR_SYMBOLS = []

        def self.get_id(base, target)
          if PAIR_SYMBOLS.empty?
           pairs_response = HTTP.get(PAIR_SYMBOLS_URL)
           PAIR_SYMBOLS << pairs_response.parse(:json)
          end
            # filtering through asset dictionary to find market_pair and obtaining the market_pair base and target's ID
            pair = PAIR_SYMBOLS[0].select{ |s| s["tokenPair"]["tokenA"]["symbol"] == base && s["tokenPair"]["tokenB"]["symbol"] == target }
          pair
        end
      end
    end
  end
end
