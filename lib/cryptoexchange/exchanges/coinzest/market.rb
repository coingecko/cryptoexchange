module Cryptoexchange::Exchanges
  module Coinzest
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinzest'
      API_URL = 'https://api.coinzest.co.kr/api/public'
    end
  end
end
