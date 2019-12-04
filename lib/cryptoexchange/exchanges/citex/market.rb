module Cryptoexchange::Exchanges
  module Citex
    class Market < Cryptoexchange::Models::Market
      NAME='citex'
      API_URL = 'https://open.citex.co.kr/api/v1/common'

      def self.trade_page_url(args={})
        "https://trade.citex.co.kr/trade/#{args[:base].upcase}_#{args[:target].upcase}"
      end
    end
  end
end
