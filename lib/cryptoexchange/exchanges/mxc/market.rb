module Cryptoexchange::Exchanges
  module Mxc
    class Market < Cryptoexchange::Models::Market
      NAME = 'mxc'
      API_URL = 'https://www.mxc.com/open/api/v1'

      def self.trade_page_url(args={})
        "https://www.mxc.com/trade.html?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
