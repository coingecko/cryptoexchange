module Cryptoexchange::Exchanges
  module Idex
    class Market < Cryptoexchange::Models::Market
      NAME = 'idex'
      API_URL = 'https://api.idex.market'
    end
  end
end
