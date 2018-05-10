module Cryptoexchange::Exchanges
  module Heat
    module Services
      class IdFetcher
        PAIR_SYMBOLS_URL = "#{Cryptoexchange::Exchanges::Heat::Market::API_URL}/exchange/assets/protocol1/0/100"
        PAIR_SYMBOLS = []

        def self.get_id(base, target)
          if PAIR_SYMBOLS.empty?
           pairs_response = HTTP.get(PAIR_SYMBOLS_URL)
           PAIR_SYMBOLS << pairs_response.parse(:json)
          end
            # filtering through asset dictionary to find market_pair and obtaining the market_pair base and target's ID
            base_id = base == 'HEAT' ? 0 : (PAIR_SYMBOLS[0].select{ |s| s['symbol'] == base })[0]['asset']
            target_id = target == 'HEAT' ? 0 : (PAIR_SYMBOLS[0].select{ |s| s['symbol'] == target })[0]['asset']
          [base_id, target_id]
        end
      end
    end
  end
end
