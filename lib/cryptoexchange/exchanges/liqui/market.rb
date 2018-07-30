module Cryptoexchange::Exchanges
  module Liqui
    class Market < Cryptoexchange::Models::Market
      NAME = 'liqui'
      API_URL = 'https://api.liqui.io/api/3'
    end
  end
end
