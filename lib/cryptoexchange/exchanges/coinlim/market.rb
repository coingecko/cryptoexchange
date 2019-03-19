module Cryptoexchange::Exchanges
  module Coinlim
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinlim'
      API_URL = 'https://openapi.coinlim.com'
    end
  end
end
