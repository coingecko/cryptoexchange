module Cryptoexchange::Exchanges
  module Luno
    class Market < Cryptoexchange::Models::Market
      NAME = 'luno'
      API_URL = 'https://api.mybitx.com/api/1'
    end
  end
end
