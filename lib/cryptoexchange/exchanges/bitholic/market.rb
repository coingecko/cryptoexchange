module Cryptoexchange::Exchanges
  module Bitholic
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitholic'
      API_URL = 'https://api.bitholic.com/public'

      def self.trade_page_url(args={})
        "https://www.bitholic.com/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
