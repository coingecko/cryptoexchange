module Cryptoexchange::Exchanges
  module BtcExchange
    class Market
      NAME = 'btc_exchange'
      API_URL = 'https://api.btc-exchange.com/papi/web'

      def self.trade_page_url(args={})
        "https://www.btc-exchange.com/"
      end
    end
  end
end
