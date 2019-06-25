module Cryptoexchange::Exchanges
  module Fubt
    class Market < Cryptoexchange::Models::Market
      NAME = 'fubt'
      API_URL = 'https://api.fubt.co/v1'
      ACCESS_KEY = "8KdBkefrMLSP0EURre4SRTYVDZnWhl3hvzi21A2YxTo%3d"
      SEPARATOR_REGEX = /(BTC|ETH|USDT|FBT|)\z/

      def self.trade_page_url(args={})
        "https://www.fubt.com/#/TradeCenter"
      end
    end
  end
end
