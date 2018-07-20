module Cryptoexchange::Exchanges
  module Tidex
    class Market < Cryptoexchange::Models::Market
      NAME = 'tidex'
      API_URL = 'https://api.tidex.com/api/3'
    end
  end
end
