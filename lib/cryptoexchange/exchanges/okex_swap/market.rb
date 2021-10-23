module Cryptoexchange::Exchanges
  module OkexSwap
    class Market < Cryptoexchange::Models::Market
      NAME = 'okex_swap'
      API_URL = 'https://www.okex.com/api/swap/v3'
 
      def self.trade_page_url(args={})
        "https://www.okex.com/future/swap"
      end
    end
  end
end
