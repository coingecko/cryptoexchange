module Cryptoexchange::Exchanges
  module Hopex
    class Market < Cryptoexchange::Models::Market
      NAME = 'hopex'
      API_URL = 'https://api2.hopex.com/api/v1'

      def self.trade_page_url(args={})
        "https://web.hopex.com/trade?marketCode=#{args[:inst_id]}"
      end
    end
  end
end
