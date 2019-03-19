module Cryptoexchange::Exchanges
  module Bithumb
    class Market < Cryptoexchange::Models::Market
      NAME = 'bithumb'
      API_URL = 'https://api.bithumb.com'

      def self.trade_page_url(args={})
        "https://www.bithumb.com/trade/order/#{args[:base].upcase}"
      end
    end
  end
end
