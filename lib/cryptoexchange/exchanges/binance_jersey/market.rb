module Cryptoexchange::Exchanges
  module BinanceJersey
    class Market < Cryptoexchange::Models::Market
      NAME = 'binance_jersey'
      API_URL = 'https://api.binance.je/api/v1'

      def self.trade_page_url(args={})
        "https://www.binance.je/trade.html?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
