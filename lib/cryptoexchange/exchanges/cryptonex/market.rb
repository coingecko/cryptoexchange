module Cryptoexchange::Exchanges
  module Cryptonex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cryptonex'
      API_URL = 'https://userapi.cryptonex.org/api'
    end
  end
end
