module Cryptoexchange::Exchanges
  module DachExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'dach_exchange'
      API_URL = 'https://dach.exchange/api/public'
    end
  end
end
