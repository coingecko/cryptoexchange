module Cryptoexchange::Exchanges
  module Bitcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitcoin'
      API_URL = 'https://api.exchange.bitcoin.com/api/2/public'

      def self.trade_page_url(args={})
        "https://exchange.bitcoin.com/exchange/#{args[:base]}-to-#{args[:target]}"
      end
    end
  end
end
