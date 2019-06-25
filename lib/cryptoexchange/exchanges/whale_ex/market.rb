module Cryptoexchange::Exchanges
  module WhaleEx
    class Market < Cryptoexchange::Models::Market
      NAME = 'whale_ex'
      API_URL = 'https://api.whaleex.com/BUSINESS/api/public/v1'

      def self.trade_page_url(args={})
        "https://www.whaleex.com/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
