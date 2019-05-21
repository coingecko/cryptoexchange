module Cryptoexchange::Exchanges
  module Floatsv
    class Market < Cryptoexchange::Models::Market
      NAME = 'floatsv'
      API_URL = 'https://www.floatsv.com/api'

      def self.trade_page_url(args={})
        "https://www.floatsv.com/spot/trade#product=#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
