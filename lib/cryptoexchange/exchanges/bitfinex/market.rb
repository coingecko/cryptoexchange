module Cryptoexchange::Exchanges
  module Bitfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitfinex'
      API_URL = 'https://api.bitfinex.com/v2'
      WS_URL = 'wss://api.bitfinex.com/ws/'
    end
  end
end
