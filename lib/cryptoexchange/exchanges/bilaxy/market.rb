module Cryptoexchange::Exchanges
  module Bilaxy
    class Market < Cryptoexchange::Models::Market
      NAME    = 'bilaxy'
      API_URL = 'https://newapi.bilaxy.com/v1'

      def self.trade_page_url(args={})
        "https://bilaxy.com/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
