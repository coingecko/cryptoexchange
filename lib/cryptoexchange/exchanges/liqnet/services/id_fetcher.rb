module Cryptoexchange::Exchanges
  module Liqnet
    module Services
      class IdFetcher
        PAIR_SYMBOLS_URL = "#{Cryptoexchange::Exchanges::Liqnet::Market::API_URL}/markets"
        PAIR_SYMBOLS = []
        
        def self.get_id(market_pair)
          if PAIR_SYMBOLS.empty?
           pairs_response = HTTP.get(PAIR_SYMBOLS_URL)
           PAIR_SYMBOLS << pairs_response.parse(:json)
          end
            # filtering through asset dictionary to find market_pair and obtaining the market_pair base and target's ID
            pair = PAIR_SYMBOLS[0].select{ |s| s['market'] == "#{market_pair.base.upcase}/#{market_pair.target.upcase}" }
          pair[0]['id']
        end
      end
    end
  end
end
