module Cryptoexchange::Exchanges
  module CoinExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'coin_exchange'
      API_URL = 'https://www.coinexchange.io/api/v1'
    end
  end
end
