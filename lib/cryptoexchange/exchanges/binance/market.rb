module Cryptoexchange::Exchanges
  module Binance
    class Market < Cryptoexchange::Models::Market
      NAME = 'binance'
      API_URL = 'https://api.binance.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.binance.com/en/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
