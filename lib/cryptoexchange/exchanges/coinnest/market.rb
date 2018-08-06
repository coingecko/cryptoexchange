module Cryptoexchange::Exchanges
  module Coinnest
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinnest'
      API_URL = 'https://api.coinnest.co.kr'

      def self.trade_page_url(args={})
        "https://www.coinnest.co.kr/market-#{args[:base].downcase}"
      end
    end
  end
end
