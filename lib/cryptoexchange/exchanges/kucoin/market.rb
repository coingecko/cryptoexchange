module Cryptoexchange::Exchanges
  module Kucoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'kucoin'
      API_URL = 'https://api.kucoin.com/v1'

      def self.trade_page_url(args={})
        "https://www.kucoin.com/#/trade.pro/#{args[:base].upcase}-#{args[:target].upcase}"
      end
    end
  end
end
