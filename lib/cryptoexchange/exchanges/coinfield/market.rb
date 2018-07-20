module Cryptoexchange::Exchanges
  module Coinfield
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinfield'
      API_URL = 'https://platform.coinfield.com/api/v2/'
    end
  end
end
