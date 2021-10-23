module Cryptoexchange::Exchanges
  module Novadax
    class Market < Cryptoexchange::Models::Market
      NAME = 'novadax'
      API_URL = 'https://api.novadax.com/v1'

      def self.trade_page_url(args={})
        "https://www.novadax.com/product/orderbook?pair=#{args[:base].upcase}_#{args[:target].upcase}"
      end
    end
  end
end
