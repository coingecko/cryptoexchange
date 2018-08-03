module Cryptoexchange::Exchanges
  module KKex
    class Market < Cryptoexchange::Models::Market
      NAME = 'k_kex'
      API_URL = 'https://kkex.com/api/v1'
    end
  end
end
