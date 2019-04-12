module Cryptoexchange::Exchanges
  module Btcexa
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcexa'
      API_URL = 'https://api.btcexa.com/api'
    end
  end
end
