module Cryptoexchange::Exchanges
  module Fourteenbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'fourteenbit'
      API_URL = 'http://broadcast.lo/v1'
    end
  end
end