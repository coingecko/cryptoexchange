module Cryptoexchange::Exchanges
  module Zgtop
    class Market < Cryptoexchange::Models::Market
      NAME = 'zgtop'
      API_URL = 'https://www.zg.top/API/api/v2'

      def self.trade_page_url(args={})
        "https://www.zg.top"
      end      
    end
  end
end
