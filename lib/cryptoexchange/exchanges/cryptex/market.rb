module Cryptoexchange::Exchanges
  module Cryptex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cryptex'
      API_URL = 'https://cryptex.net/api/v1'
    end
  end
end
