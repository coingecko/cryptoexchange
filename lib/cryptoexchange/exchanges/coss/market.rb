module Cryptoexchange::Exchanges
  module Coss
    class Market < Cryptoexchange::Models::Market
      NAME = 'coss'
      API_URL = 'https://exchange.coss.io/api'
    end
  end
end
