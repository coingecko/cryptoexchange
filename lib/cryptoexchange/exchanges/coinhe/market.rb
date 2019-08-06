module Cryptoexchange::Exchanges
  module Coinhe
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinhe'
      API_URL = 'https://api.coinhe.io/v1'

      def self.trade_page_url(args={})
        "https://coinhe.io/trading/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
