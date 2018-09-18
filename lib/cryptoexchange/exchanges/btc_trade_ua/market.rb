module Cryptoexchange::Exchanges
  module BtcTradeUa
    class Market < Cryptoexchange::Models::Market
      NAME = 'btc_trade_ua'
      API_URL = 'https://btc-trade.com.ua/api'

      def self.trade_page_url(args={})
        "https://btc-trade.com.ua/stock/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
