module Cryptoexchange::Exchanges
  module Coinsbank
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinsbank'
      API_URL = 'https://coinsbank.com/sapi'
    end
  end
end
