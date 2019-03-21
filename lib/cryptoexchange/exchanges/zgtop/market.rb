module Cryptoexchange::Exchanges
  module Zgtop
    class Market < Cryptoexchange::Models::Market
      NAME = 'zgtop'
      API_URL = 'https://www.zgtop.io/API/api/v1'

      def self.trade_page_url(args={})
        "https://zgtop.io/"
      end
    end
  end
end
