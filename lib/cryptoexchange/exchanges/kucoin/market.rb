module Cryptoexchange::Exchanges
  module Kucoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'kucoin'
      API_URL = 'https://api.kucoin.com/v1'
    end
  end
end
