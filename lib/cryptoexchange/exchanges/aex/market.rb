module Cryptoexchange::Exchanges
  module Aex
    class Market < Cryptoexchange::Models::Market
      NAME = 'aex'
      API_URL = 'https://api.aex.com'
    end
  end
end
