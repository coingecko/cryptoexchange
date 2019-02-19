module Cryptoexchange::Exchanges
  module Altmarkets
    class Market < Cryptoexchange::Models::Market
      NAME = 'altmarkets'
      API_URL = 'https://altmarkets.io/swagger?url=/api/v2/swagger'

      def self.trade_page_url(args = {})
        "https://altmarkets.io/trading/#{args[:target]}#{args[:base]}"
      end
    end
  end
end
