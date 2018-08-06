module Cryptoexchange::Exchanges
  module Koinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'koinex'
      API_URL = 'https://koinex.in/api'
    end
  end
end
