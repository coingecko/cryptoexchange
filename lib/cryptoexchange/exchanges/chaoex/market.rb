module Cryptoexchange::Exchanges
  module Chaoex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'chaoex'
      API_URL = 'https://www.chaoex.info/unique'
    end
  end
end
