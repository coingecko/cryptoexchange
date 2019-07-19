module Cryptoexchange::Exchanges
  module Xfutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'xfutures'
      API_URL = 'https://www.xfutures.io/api'

      def self.trade_page_url(args={})
        "https://www.xfutures.io/spot/trade#product=#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
