module Cryptoexchange::Exchanges
  module Bione
    class Market
      NAME = 'bione'
      API_URL = 'https://bione.cc/api/v2'

      def self.trade_page_url(args={})
        "https://www.bione.cc/index/trade/index/market/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
