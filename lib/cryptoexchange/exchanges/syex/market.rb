module Cryptoexchange::Exchanges
  module Syex
    class Market < Cryptoexchange::Models::Market
      NAME = 'syex'
      TARGET_SYM = 'USDT'
      API_URL = 'https://api-new.syex.io/pc/coinMarket/v1'

      def self.trade_page_url(args={})
        "https://www.syex.io/#/tradeCenter?payCoinName=#{args[:target]}&coinName=#{args[:base]}"
      end
    end
  end
end
