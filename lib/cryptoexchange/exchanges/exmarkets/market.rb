module Cryptoexchange::Exchanges
  module Exmarkets
    class Market < Cryptoexchange::Models::Market
      NAME = 'exmarkets'
      API_URL = 'https://exmarkets.com/api/trade/v1'

      def self.trade_page_url(args = {})
        "https://exmarkets.com/trade/#{args[:base]}-#{args[:target]}".downcase
      end
    end
  end
end
