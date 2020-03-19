module Cryptoexchange::Exchanges
  module Cointiger
    class Market < Cryptoexchange::Models::Market
      NAME = 'cointiger'
      API_URL = 'https://api.cointiger.com/exchange/trading/api/market'
      MARKET_URL = 'https://www.cointiger.com/exchange/api/public/market/detail/v4'
    end
  end
end
