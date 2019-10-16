module Cryptoexchange::Exchanges
  module Fubt
    class Market < Cryptoexchange::Models::Market
      NAME = 'fubt'
      API_URL = 'https://api.fubt.co/v1'
      ACCESS_KEY = "koiyqwih5Ll8Fz9KvnK6561H0wctqGEu%2bMR49VIlEnk%3d"
      SEPARATOR_REGEX = /(BTC|ETH|USDT|FBT|)\z/

      def self.trade_page_url(args={})
        "https://www.fubt.com/#/TradeCenter"
      end
    end
  end
end
