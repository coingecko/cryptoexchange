module Cryptoexchange::Exchanges
  module Qtrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'qtrade'
      API_URL = 'https://api.qtrade.io/v1'
    end
  end
end
