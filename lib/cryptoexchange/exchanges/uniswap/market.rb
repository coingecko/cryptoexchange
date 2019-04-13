module Cryptoexchange::Exchanges
  module Uniswap
    class Market < Cryptoexchange::Models::Market
      NAME = 'uniswap'
      API_URL = 'https://uniswap-analytics.appspot.com/api/v1'
    end
  end
end
