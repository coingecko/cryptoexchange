module Cryptoexchange::Exchanges
  module Qbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'qbtc'
      API_URL = 'https://www.qbtc.me/json'

      def self.trade_page_url(args={})
        "https://www.qbtc.me/trade?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
