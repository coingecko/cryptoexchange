module Cryptoexchange::Exchanges
  module Digifinex
    class Market
      NAME = 'digifinex'
      API_URL = 'https://openapi.digifinex.vip/v2'

      #API_URL_V3 is used for order_book and trades, this url version is newly launched and does not support tickers
      API_URL_V3 = 'https://openapi.digifinex.vip/v3'

      def self.trade_page_url(args = {})
        "https://www.digifinex.com/en-ww/trade/#{args[:target]}/#{args[:base]}"
      end
    end
  end
end
