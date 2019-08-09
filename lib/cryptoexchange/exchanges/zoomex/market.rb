module Cryptoexchange::Exchanges
  module Zoomex
    class Market < Cryptoexchange::Models::Market
      NAME = 'zoomex'
      API_URL = 'https://www.zooomex.com/api/v2/trade'

      def self.trade_page_url(args={})
        "https://www.zooomex.com/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
