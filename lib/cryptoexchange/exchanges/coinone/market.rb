module Cryptoexchange::Exchanges
  module Coinone
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinone'
      API_URL = 'https://api.coinone.co.kr'
    end
  end
end
