module Cryptoexchange::Exchanges
  module Atomars
    class Market < Cryptoexchange::Models::Market
      NAME = 'Atomars'
      API_URL = 'https://api.atomars.com/v1/coingecko'
    end
  end
end
