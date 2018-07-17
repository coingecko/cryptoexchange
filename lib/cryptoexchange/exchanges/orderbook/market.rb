module Cryptoexchange::Exchanges
  module Orderbook
    class Market < Cryptoexchange::Models::Market
      NAME = 'orderbook'
      API_URL = 'https://api.orderbook.io'
    end
  end
end
