module Cryptoexchange::Exchanges
  module Tradeio
    class Market < Cryptoexchange::Models::Market
      NAME = 'tradeio'
      API_URL = 'https://api.exchange.trade.io'
    end
  end
end
