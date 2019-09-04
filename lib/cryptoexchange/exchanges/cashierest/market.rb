module Cryptoexchange::Exchanges
  module Cashierest
    class Market < Cryptoexchange::Models::Market
      NAME = 'cashierest'
      API_URL = 'https://rest.cashierest.com/Public'

      def self.trade_page_url(args={})
        "https://www.cashierest.com/Stock/KrwStock"
      end
    end
  end
end
