module Cryptoexchange::Exchanges
  module Coinnox
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinnox'
      API_URL = 'https://coinnox.com/api/v2'
    end
  end
end
