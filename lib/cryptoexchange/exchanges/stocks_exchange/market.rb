module Cryptoexchange::Exchanges
  module StocksExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'stocks_exchange'
      API_URL = 'https://api3.stex.com/public'

      def self.trade_page_url(args={})
        "https://app.stex.com/en/basic-trade/pair/#{args[:target]}/#{args[:base]}/240"
      end
    end
  end
end
