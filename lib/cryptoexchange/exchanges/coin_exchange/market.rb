module Cryptoexchange::Exchanges
  module CoinExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'coin_exchange'
      API_URL = 'https://www.coinexchange.io/api/v1'

      def self.trade_page_url(args = {})
        "https://www.coinexchange.io/market/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
