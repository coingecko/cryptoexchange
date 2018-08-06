module Cryptoexchange::Exchanges
  module Nibyx
    class Market < Cryptoexchange::Models::Market
      NAME = 'nibyx'
      API_URL = 'https://nibyx.com/api/v1'
    end
  end
end
