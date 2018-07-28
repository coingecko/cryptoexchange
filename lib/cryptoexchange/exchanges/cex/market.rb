module Cryptoexchange::Exchanges
  module Cex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cex'
      API_URL = 'https://cex.io/api'
    end
  end
end
