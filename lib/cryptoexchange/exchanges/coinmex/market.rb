module Cryptoexchange::Exchanges
  module Coinmex
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinmex'
      API_URL = 'https://www.coinmex.com/api/v1'
    end
  end
end
