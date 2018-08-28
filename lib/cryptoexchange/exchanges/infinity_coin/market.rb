module Cryptoexchange::Exchanges
  module InfinityCoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'infinity_coin'
      API_URL = 'https://infinitycoin.exchange'

      def self.trade_page_url(args={})
        "https://infinitycoin.exchange/exchange/#{args[:base]}"
      end
    end
  end
end
