module Cryptoexchange::Exchanges
  module Coinzo
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinzo'
      API_URL = 'https://api.coinzo.com'

      def self.trade_page_url(args={})
        "https://www.coinzo.com/market/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
