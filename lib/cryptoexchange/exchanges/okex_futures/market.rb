module Cryptoexchange::Exchanges
  module OkexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'okex_futures'
      API_URL = 'https://www.okex.com/api/swap/v3'

      def self.trade_page_url(args={})
        "https://www.okex.com/future/swap"
      end
    end
  end
end
