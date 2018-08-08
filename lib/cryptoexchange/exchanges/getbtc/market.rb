module Cryptoexchange::Exchanges
  module Getbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'getbtc'
      API_URL = 'https://getbtc.org/api'

      def self.trade_page_url(args={})
        "https://getbtc.org/buy-sell.php?currency=#{args[:base]}"
      end
    end
  end
end
