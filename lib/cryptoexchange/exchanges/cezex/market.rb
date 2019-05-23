module Cryptoexchange::Exchanges
  module Cezex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cezex'
      API_URL = 'https://beta.cezex.io/api/v2'
    end
  end
end

