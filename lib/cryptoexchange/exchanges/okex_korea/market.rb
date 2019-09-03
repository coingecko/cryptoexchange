module Cryptoexchange::Exchanges
  module OkexKorea
    class Market < Cryptoexchange::Models::Market
      NAME = 'okex_korea'
      API_URL = 'https://okex.co.kr/api/spot/v3'

      def self.trade_page_url(args={})
        "https://okex.co.kr/kr/view/trade/order"
      end
    end
  end
end
