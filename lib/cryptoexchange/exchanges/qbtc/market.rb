module Cryptoexchange::Exchanges
  module Qbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'qbtc'
      API_URL = 'https://www.myqbtc.com/json'

      def self.trade_page_url(args={})
        "https://www.myqbtc.com/markets?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
