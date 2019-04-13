module Cryptoexchange::Exchanges
  module Bittrex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bittrex'
      API_URL = 'https://bittrex.com/api/v1.1'

      def self.trade_page_url(args={})
        "https://bittrex.com/Market/Index?MarketName=#{args[:target].upcase}-#{args[:base].upcase}"
      end
    end
  end
end
