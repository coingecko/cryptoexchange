module Cryptoexchange::Exchanges
  module Liqnet
    module Services
      class IdFetcher
        PAIR_SYMBOLS_URL = "#{Cryptoexchange::Exchanges::Liqnet::Market::API_URL}/markets"

        def self.get_id(market_pair)
          # To-do: aim to optimize call for pair id
           pairs_response = HTTP.get(PAIR_SYMBOLS_URL)
           pairs_response = pairs_response.parse(:json)
            # filtering through asset dictionary to find market_pair and obtaining the market_pair base and target's ID
           pair = pairs_response.select{ |s| s['market'] == "#{market_pair.base.upcase}/#{market_pair.target.upcase}" }
          pair[0]['id']
        end
      end
    end
  end
end
