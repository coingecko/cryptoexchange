module Cryptoexchange::Exchanges
  module TradeOgre
    class Market < Cryptoexchange::Models::Market
      NAME = 'trade_ogre'
      API_URL = 'https://tradeogre.com/api/v1'

      def self.trade_page_url(args={})
        "https://tradeogre.com/exchange/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
