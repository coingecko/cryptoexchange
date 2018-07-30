module Cryptoexchange::Exchanges
  module StocksExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'stocks_exchange'
      API_URL = 'https://app.stocks.exchange/api2'
    end
  end
end
