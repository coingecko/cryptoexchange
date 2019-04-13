module Cryptoexchange::Exchanges
  module Kucoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'kucoin'
      API_URL = 'https://openapi-v2.kucoin.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.kucoin.com/trade/#{args[:base].upcase}-#{args[:target].upcase}"
      end
    end
  end
end
