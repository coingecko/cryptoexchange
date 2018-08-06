module Cryptoexchange::Exchanges
  module Coss
    class Market < Cryptoexchange::Models::Market
      NAME = 'coss'
      API_URL = 'https://exchange.coss.io/api'

      def self.trade_page_url(args={})
        "https://exchange.coss.io/exchange/#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
