module Cryptoexchange::Exchanges
  module Bitex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitex'
      API_URL = 'https://bitex.la/api-v1/rest'
    end
  end
end
