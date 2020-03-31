module Cryptoexchange::Exchanges
  module Btcturk
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcturk'
      API_URL = 'https://api.btcturk.com/api/v2'
    end
  end
end
