module Cryptoexchange::Exchanges
  module Ftx
    class Market < Cryptoexchange::Models::Market
      NAME = 'ftx'
      API_URL = 'https://ftx.com/api'

      def self.trade_page_url(args={})
        "https://ftx.com/futures"
      end
    end
  end
end
