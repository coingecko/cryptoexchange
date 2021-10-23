module Cryptoexchange::Exchanges
  module BinanceUs
    class Market < Cryptoexchange::Models::Market
      NAME = 'binance_us'
      API_URL = 'https://api.binance.us/api/v1'

      def self.trade_page_url(args={})
        "https://www.binance.us/en/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
