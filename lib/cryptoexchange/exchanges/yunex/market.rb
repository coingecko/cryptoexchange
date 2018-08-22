module Cryptoexchange::Exchanges
  module Yunex
    class Market < Cryptoexchange::Models::Market
      NAME = 'yunex'
      API_URL = 'https://a.yunex.io'

      def self.trade_page_url(args={})
        "https://yunex.io/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
