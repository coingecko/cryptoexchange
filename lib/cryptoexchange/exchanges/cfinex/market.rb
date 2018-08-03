module Cryptoexchange::Exchanges
  module Cfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cfinex'
      API_URL = 'https://cfinex.com/api'
    end
  end
end
