module Cryptoexchange::Exchanges
  module Vebitcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'vebitcoin'
      API_URL = 'https://prod-data-publisher.azurewebsites.net/api'

      def self.trade_page_url(args={})
        "https://www.vebitcoin.com/market/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
