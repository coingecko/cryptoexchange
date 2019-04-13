module Cryptoexchange::Exchanges
  module Bigmarkets
    class Market < Cryptoexchange::Models::Market
      NAME = 'bigmarkets'
      API_URL = 'http://api.bigmarkets.io'

      def self.trade_page_url(args={})
        "https://www.bigmarkets.io/dashboard"
      end
    end
  end
end
