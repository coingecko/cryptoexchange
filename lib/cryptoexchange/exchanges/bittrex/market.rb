module Cryptoexchange::Exchanges
  module Bittrex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bittrex'
      API_URL = 'https://bittrex.com/api/v1.1'
    end
  end
end
