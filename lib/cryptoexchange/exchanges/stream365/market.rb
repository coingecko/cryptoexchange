module Cryptoexchange::Exchanges
  module Stream365
    class Market < Cryptoexchange::Models::Market
      NAME = 'stream365'
      API_URL = 'https://api.365.stream'

      def self.trade_page_url(args={})
        "https://365.stream/exchange/#{args[:target]}_#{args[:base]}"
      end
    end
  end
end
