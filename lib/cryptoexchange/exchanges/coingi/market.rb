module Cryptoexchange::Exchanges
  module Coingi
    class Market < Cryptoexchange::Models::Market
      NAME = 'coingi'
      API_URL = 'https://api.coingi.com'

      def self.trade_page_url(args={})
        "https://coingi.com/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
