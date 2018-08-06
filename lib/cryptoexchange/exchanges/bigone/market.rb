module Cryptoexchange::Exchanges
  module Bigone
    class Market < Cryptoexchange::Models::Market
      NAME = 'bigone'
      API_URL = 'https://big.one/api/v2'
    end
  end
end
