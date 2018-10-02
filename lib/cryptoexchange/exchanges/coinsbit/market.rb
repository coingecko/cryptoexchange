module Cryptoexchange::Exchanges
  module Coinsbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinsbit'
      API_URL = 'https://coinsbit.io/api/v1'
    end
  end
end
