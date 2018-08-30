module Cryptoexchange::Exchanges
  module BtcAlpha
    class Market < Cryptoexchange::Models::Market
      NAME = 'btc_alpha'
      API_URL = 'https://btc-alpha.com/api/v1'
      TICKER_URL = 'https://btc-alpha.com/api'

      def self.trade_page_url(args={})
        "https://btc-alpha.com/exchange/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
