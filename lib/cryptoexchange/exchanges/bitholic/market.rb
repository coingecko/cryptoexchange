module Cryptoexchange::Exchanges
  module Bitholic
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitholic'
      API_URL = 'https://api.bitholic.com/public'

      def self.trade_page_url(args={})
        "https://www.bithumbsg.com/exchange/#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
