module Cryptoexchange::Exchanges
  module TradeSatoshi
    class Market < Cryptoexchange::Models::Market
      NAME = 'trade_satoshi'
      API_URL = 'https://tradesatoshi.com/api/public'

      def self.trade_page_url(args={})
        "https://tradesatoshi.com/Exchange?market=#{args[:base].upcase}_#{args[:target].upcase}"
      end
    end
  end
end
