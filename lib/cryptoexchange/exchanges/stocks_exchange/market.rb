module Cryptoexchange::Exchanges
  module StocksExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'stocks_exchange'
      API_URL = 'https://app.stocks.exchange/api2'

      def self.trade_page_url(args={})
        "https://app.stocks.exchange/en/basic-trade/pair/#{args[:target]}/#{args[:base]}/1D"
      end
    end
  end
end
