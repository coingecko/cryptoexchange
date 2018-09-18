module Cryptoexchange::Exchanges
  module Dobitrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'dobitrade'
      API_URL = 'https://api.dobitrade.com'
    end
  end
end
