module Cryptoexchange::Exchanges
  module Bytex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bytex'
      API_URL = 'https://openapi.bytex.io/open/api'
    end
  end
end
