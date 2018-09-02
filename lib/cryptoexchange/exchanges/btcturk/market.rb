module Cryptoexchange::Exchanges
  module Btcturk
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcturk'
      API_URL = 'https://www.btcturk.com/api'
    end
  end
end
