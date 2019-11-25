module Cryptoexchange::Exchanges
  module Resfinex
    class Market < Cryptoexchange::Models::Market
      NAME='resfinex'
      API_URL = 'https://api.resfinex.com/engine'

      def self.trade_page_url(args={})
        "https://trade.resfinex.com/?pair=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
