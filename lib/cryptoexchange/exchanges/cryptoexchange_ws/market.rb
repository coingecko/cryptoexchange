module Cryptoexchange::Exchanges
  module CryptoexchangeWs
    class Market < Cryptoexchange::Models::Market
      NAME = 'cryptoexchange_ws'
      API_URL = 'https://cryptoexchange.ws/en/gateway'

      def self.trade_page_url(args={})
        "https://cryptoexchange.ws/en"
      end
    end
  end
end
