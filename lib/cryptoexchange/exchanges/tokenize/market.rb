module Cryptoexchange::Exchanges
  module Tokenize
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokenize'
      API_URL = 'https://api2.tokenize.exchange/public/v1'

      def self.trade_page_url(args = {})
        "https://tokenize.exchange/market/#{args[:target]}-#{args[:base]}"
      end      
    end
  end
end
