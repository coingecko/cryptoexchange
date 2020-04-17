module Cryptoexchange::Exchanges
  module BitmartFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitmart_futures'
      API_URL = 'https://api-cloud.bitmart.com/contract/v1'

      def self.trade_page_url(args={})
        "https://futures.bitmart.com/?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
