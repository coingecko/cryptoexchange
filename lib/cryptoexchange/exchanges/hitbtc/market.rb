module Cryptoexchange::Exchanges
  module Hitbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'hitbtc'
      API_URL = 'http://api.hitbtc.com/api/1'
    end
  end
end
