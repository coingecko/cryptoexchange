module Cryptoexchange::Exchanges
  module Coinrail
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinrail'
      API_URL = 'https://api.coinrail.co.kr'
      TICKER_URL = 'https://coinrail.co.kr/main/market_info'

      def self.trade_page_url(args={})
        "https://coinrail.co.kr/api/public/system/market/info?fiat_currency=#{args[:target]}&lang=ko"
      end
    end
  end
end
