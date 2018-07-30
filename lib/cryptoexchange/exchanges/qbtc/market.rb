module Cryptoexchange::Exchanges
  module Qbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'qbtc'
      API_URL = 'https://www.qbtc.com/json'
    end
  end
end
