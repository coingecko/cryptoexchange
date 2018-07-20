module Cryptoexchange::Exchanges
  module Bitforex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitforex'
      API_URL = 'https://www.bitforex.com/server'
    end
  end
end
