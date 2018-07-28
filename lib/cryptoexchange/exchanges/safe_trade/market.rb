module Cryptoexchange::Exchanges
  module SafeTrade
    class Market < Cryptoexchange::Models::Market
      NAME    = 'safe_trade'
      API_URL = 'https://safe.trade/api'
    end
  end
end
