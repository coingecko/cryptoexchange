module Cryptoexchange::Exchanges
  module BinanceUganda
    class Market < Cryptoexchange::Models::Market
      NAME = 'binance_uganda'
      API_URL = 'https://api.binance.co.ug/api/v1'

      def self.trade_page_url(args={})
        "https://www.binance.co.ug/trade.html?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
