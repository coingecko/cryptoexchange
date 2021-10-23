module Cryptoexchange::Exchanges
  module Swiftex
    class Market < Cryptoexchange::Models::Market
      NAME = 'swiftex'
      API_URL = 'https://trade.swiftex.co/api/v2/peatio/public'

      def self.trade_page_url(args={})
        "https://trade.swiftex.co/trading/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
