module Cryptoexchange::Exchanges
  module Vitex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'vitex'
      API_URL = 'https://vitex.vite.net/api/v1'

      def self.trade_page_url(args={})
        "https://x.vite.net/trade?symbol=#{args[:base].upcase}_#{args[:target].upcase}"
      end
    end
  end
end
