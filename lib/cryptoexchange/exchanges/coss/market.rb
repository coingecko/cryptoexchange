module Cryptoexchange::Exchanges
  module Coss
    class Market < Cryptoexchange::Models::Market
      NAME = 'coss'
      API_URL = 'https://exchange.coss.io/api'

      def self.trade_page_url(args={})
        "https://coss.io/c/trade?s=#{args[:base].upcase}_#{args[:target].upcase}"
      end
    end
  end
end
