module Cryptoexchange::Exchanges
  module Binance
    class Market
      NAME = 'binance'
      API_URL = 'https://www.binance.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.binance.com/trade.html?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
