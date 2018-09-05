module Cryptoexchange::Exchanges
  module NanuExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'nanu_exchange'
      API_URL = 'https://nanu.exchange/public?command'
    end
  end
end
