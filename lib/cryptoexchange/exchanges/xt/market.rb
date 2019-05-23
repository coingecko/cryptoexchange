module Cryptoexchange::Exchanges
  module Xt
    class Market < Cryptoexchange::Models::Market
      NAME = 'xt'
      API_URL = 'https://kline.xt.com/api/data/v1'

      def self.trade_page_url(args={})
        "https://www.xt.com/trade/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
