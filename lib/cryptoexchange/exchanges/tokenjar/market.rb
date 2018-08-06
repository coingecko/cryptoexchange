module Cryptoexchange::Exchanges
  module Tokenjar
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokenjar'
      API_URL = 'https://tokenjar.io/api/cmc'
    end
  end
end
