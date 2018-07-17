module Cryptoexchange::Exchanges
  module Okex
    class Market < Cryptoexchange::Models::Market
      NAME = 'okex'
      API_URL = 'https://www.okex.com/api/v1'
    end
  end
end
