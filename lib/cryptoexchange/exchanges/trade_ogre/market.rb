module Cryptoexchange::Exchanges
  module TradeOgre
    class Market < Cryptoexchange::Models::Market
      NAME = 'trade_ogre'
      API_URL = 'https://tradeogre.com/api/v1'
    end
  end
end
