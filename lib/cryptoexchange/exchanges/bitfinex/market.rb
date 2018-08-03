module Cryptoexchange::Exchanges
  module Bitfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitfinex'
      API_URL = 'https://api.bitfinex.com/v1'
    end
  end
end
