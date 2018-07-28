module Cryptoexchange::Exchanges
  module Chbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'chbtc'
      API_URL = 'http://api.chbtc.com/data/v1'
    end
  end
end
