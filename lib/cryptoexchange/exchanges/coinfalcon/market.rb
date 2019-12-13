module Cryptoexchange::Exchanges
  module Coinfalcon
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinfalcon'
      API_URL = 'https://coinfalcon.com/api/v1/'

      def self.trade_page_url(args={})
        "https://coinfalcon.com/en/"
      end
    end
  end
end
