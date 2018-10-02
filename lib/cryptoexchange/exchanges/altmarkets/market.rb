module Cryptoexchange::Exchanges
  module Altmarkets
    class Market < Cryptoexchange::Models::Market
      NAME = 'altmarkets'
      API_URL = 'https://altmarkets.cc/api/v1'

      def self.trade_page_url(args = {})
        "https://altmarkets.cc/market/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
