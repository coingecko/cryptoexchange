module Cryptoexchange::Exchanges
  module Kairex
    class Market < Cryptoexchange::Models::Market
      NAME = 'kairex'
      API_URL = 'https://api.kairex.com/v1'
    end
  end
end
