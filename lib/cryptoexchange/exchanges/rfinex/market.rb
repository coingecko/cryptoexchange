module Cryptoexchange::Exchanges
  module Rfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'rfinex'
      API_URL = 'https://rfinex.com/api/v3'
    end
  end
end
