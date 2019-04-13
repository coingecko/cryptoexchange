module Cryptoexchange::Exchanges
  module Swiftex
    class Market < Cryptoexchange::Models::Market
      NAME = 'swiftex'
      API_URL = 'https://swiftex.co/api/v2'

      def self.trade_page_url(args={})
        "https://swiftex.co/trading/#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
