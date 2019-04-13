module Cryptoexchange::Exchanges
  module Therocktrading
    class Market < Cryptoexchange::Models::Market
      NAME = 'therocktrading'
      API_URL = 'https://api.therocktrading.com/v1'

      def self.trade_page_url(args = {})
        "https://www.therocktrading.com/en/offers/#{args[:base].upcase}#{args[:target].upcase}"
      end
    end
  end
end
