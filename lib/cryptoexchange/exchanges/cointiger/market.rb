module Cryptoexchange::Exchanges
  module Cointiger
    class Market < Cryptoexchange::Models::Market
      NAME = 'cointiger'
      API_URL = 'https://api.cointiger.pro/exchange/trading/api/market'
      MARKET_URL = 'https://www.cointiger.pro/exchange/api/public/market/detail'
    end
  end
end
