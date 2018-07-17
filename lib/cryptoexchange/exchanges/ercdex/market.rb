module Cryptoexchange::Exchanges
  module Ercdex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ercdex'
      API_URL = 'https://api.ercdex.com/api'
    end
  end
end
