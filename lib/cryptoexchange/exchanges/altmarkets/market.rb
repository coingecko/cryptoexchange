module Cryptoexchange::Exchanges
  module Altmarkets
    class Market < Cryptoexchange::Models::Market
      NAME = 'altmarkets'
      API_URL = 'https://altmarkets.io/api/v2'

      def self.trade_page_url(args = {})
        "https://altmarkets.io/trading/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
