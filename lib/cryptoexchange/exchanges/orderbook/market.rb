module Cryptoexchange::Exchanges
  module Orderbook
    class Market < Cryptoexchange::Models::Market
      NAME = 'orderbook'
      API_URL = 'https://api.orderbook.io'

      def self.trade_page_url(args={})
        "https://www.orderbook.io/#/trading/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
