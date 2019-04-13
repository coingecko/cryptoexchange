module Cryptoexchange::Exchanges
  module Chainex
    class Market < Cryptoexchange::Models::Market
      NAME = 'chainex'
      API_URL = 'https://api.chainex.io'
    end
  end
end
