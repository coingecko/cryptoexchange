module Cryptoexchange::Exchanges
  module Coinzest
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinzest'
      API_URL = 'https://api.coinzest.co.kr/api/public'

      def self.trade_page_url(args={})
        "https://www.coinzest.co.kr/app/cxweb/it/IT4001.jsp"
      end
    end
  end
end
