module Cryptoexchange::Exchanges
  module Poloniex
    class Market < Cryptoexchange::Models::Market
      NAME = 'poloniex'
      API_URL = 'https://poloniex.com/public'
    end
  end
end
