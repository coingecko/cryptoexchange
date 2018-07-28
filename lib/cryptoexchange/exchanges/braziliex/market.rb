module Cryptoexchange::Exchanges
  module Braziliex
    class Market < Cryptoexchange::Models::Market
      NAME = 'braziliex'
      API_URL = 'https://braziliex.com/api/v1/public'
    end
  end
end
