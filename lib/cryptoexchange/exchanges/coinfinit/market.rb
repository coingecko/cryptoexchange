module Cryptoexchange::Exchanges
  module Coinfinit
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinfinit'
      API_URL = 'https://api.coinfinit.com/public'

      def self.trade_page_url(args={})
        "https://www.coinfinit.com/trade/order/#{args[:target].downcase}-#{args[:base].downcase}"
      end
    end
  end
end
