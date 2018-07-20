module Cryptoexchange::Exchanges
  module Kkcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'kkcoin'
      API_URL = 'https://api.kkcoin.com/rest'
    end
  end
end
