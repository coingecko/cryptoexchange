module Cryptoexchange::Exchanges
  module Okcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'okcoin'
      INT_API_URL = 'https://www.okcoin.com/api/v1'
      CN_API_URL = 'https://www.okcoin.cn/api/v1'
    end
  end
end
