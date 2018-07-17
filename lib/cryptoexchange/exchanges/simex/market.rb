module Cryptoexchange::Exchanges
  module Simex
    class Market < Cryptoexchange::Models::Market
      NAME = 'simex'
      API_URL = 'https://simex.global/api/pairs'
    end
  end
end
