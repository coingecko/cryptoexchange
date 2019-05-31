module Cryptoexchange::Exchanges
  module DachExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'dach_exchange'
      API_URL = 'https://dach.exchange/api/public'

      def self.trade_page_url(args={})
        "https://dach.exchange/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
