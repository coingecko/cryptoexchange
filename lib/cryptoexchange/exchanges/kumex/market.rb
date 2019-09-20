module Cryptoexchange::Exchanges
  module Kumex
    class Market < Cryptoexchange::Models::Market
      NAME = 'kumex'
      API_URL = 'https://api.kumex.com/api/v1'
    end
  end
end
