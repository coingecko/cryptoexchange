module Cryptoexchange::Exchanges
  module Coinhouse
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinhouse'
      API_URL = 'https://coinhouse.eu/v2'

      def self.trade_page_url(args={})
        "https://coinhouse.eu/markets/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
