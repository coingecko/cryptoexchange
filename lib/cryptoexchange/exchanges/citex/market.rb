module Cryptoexchange::Exchanges
  module Citex
    class Market < Cryptoexchange::Models::Market
      NAME='citex'
      API_URL = 'https://open.citex.co.kr/api/v1/common'
    end
  end
end
