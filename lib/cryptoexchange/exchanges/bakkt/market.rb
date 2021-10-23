module Cryptoexchange::Exchanges
  module Bakkt
    class Market < Cryptoexchange::Models::Market
      NAME = 'bakkt'
      API_URL = 'https://www.theice.com/marketdata'

      def self.trade_page_url(args={})
        "https://www.theice.com/products/72035464/Bakkt-Bitcoin-USD-Monthly-Futures/specs"
      end
    end
  end
end
