module Cryptoexchange::Exchanges
  module ZbgFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'zbg_futures'
      API_URL = 'https://www.zbg.com/exchange/api/v1/common/future'

      def self.trade_page_url(args={})
        "https://futures.zbg.com/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
