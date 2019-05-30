module Cryptoexchange::Exchanges
  module Neblidex
    class Market
      NAME = 'neblidex'
      API_URL = 'https://www.neblidex.xyz/seed/?v=1&api=get_market_ticker'
      
      def self.trade_page_url(args={})
        "https://www.neblidex.xyz"
      end
    end
  end
end
