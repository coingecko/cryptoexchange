module Cryptoexchange::Exchanges
  module Coinnest
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinnest'
      API_URL = 'https://api.coinnest.co.kr'
    end
  end
end
