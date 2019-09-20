module Cryptoexchange::Exchanges
  module Jex
    class Market < Cryptoexchange::Models::Market
      NAME = 'jex'
      API_URL = 'https://www.jex.com/api/v1'
    end
  end
end
