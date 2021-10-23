module Cryptoexchange::Exchanges
  module Coinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinex'
      API_URL = 'https://api.coinex.com/v1'
      SEPARATOR_REGEX = /(USDT|BTC|BCH|ETH|USDC|GUSD|PAX|TUSD|CET)\z/

      def self.trade_page_url(args={})
        "https://www.coinex.com/trading?currency=#{args[:target]}&dest=#{args[:base]}#limit"
      end
    end
  end
end
