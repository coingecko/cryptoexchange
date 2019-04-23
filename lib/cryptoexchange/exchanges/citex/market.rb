module Cryptoexchange::Exchanges
  module Citex
    class Market < Cryptoexchange::Models::Market
      NAME='citex'
      API_URL = 'https://api.citex.co.kr/v1/markets/common/ticker'
    end
  end
end
