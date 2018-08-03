module Cryptoexchange::Exchanges
  module Bithash
    class Market < Cryptoexchange::Models::Market
      NAME = 'bithash'
      API_URL = 'https://www.bithash.net/api'
    end
  end
end
