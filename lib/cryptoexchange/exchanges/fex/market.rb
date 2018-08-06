module Cryptoexchange::Exchanges
  module Fex
    class Market < Cryptoexchange::Models::Market
      NAME = 'fex'
      API_URL = 'http://api.fexpro.io/api'
    end
  end
end
