module Cryptoexchange::Exchanges
  module Crex24
    class Market < Cryptoexchange::Models::Market
      NAME = 'crex24'
      API_URL = 'https://api.crex24.com/v2/public/'

      def self.trade_page_url(args={})
        "https://crex24.com/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
