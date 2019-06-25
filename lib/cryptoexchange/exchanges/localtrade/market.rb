module Cryptoexchange::Exchanges
  module Localtrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'localtrade'
      API_URL = 'https://localtrade.cc/main'

      def self.trade_page_url(args={})
        "https://localtrade.cc/"
      end
    end
  end
end
