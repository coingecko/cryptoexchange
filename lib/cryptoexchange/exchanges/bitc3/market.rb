module Cryptoexchange::Exchanges
  module Bitc3
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitc3'
      API_URL = 'https://www.bitc3.com/public'

      def self.trade_page_url(args={})
        "https://www.bitc3.com/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
