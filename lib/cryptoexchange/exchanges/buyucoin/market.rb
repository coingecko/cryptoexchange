module Cryptoexchange::Exchanges
  module Buyucoin
    class Market < Cryptoexchange::Models::Market
      NAME    = 'buyucoin'
      API_URL = 'https://www.buyucoin.com/api/v1.2'
    end
  end
end
