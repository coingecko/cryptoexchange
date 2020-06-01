module Cryptoexchange::Exchanges
  module Buyucoin
    class Market < Cryptoexchange::Models::Market
      NAME    = 'buyucoin'
      API_URL = 'https://api.buyucoin.com/ticker/v1.0'
    end
  end
end
