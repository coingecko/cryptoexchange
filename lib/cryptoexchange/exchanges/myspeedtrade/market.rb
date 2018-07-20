module Cryptoexchange::Exchanges
  module Myspeedtrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'myspeedtrade'
      API_URL = 'https://myspeedtrade.com/api/v2'
    end
  end
end
