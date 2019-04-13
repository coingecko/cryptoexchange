module Cryptoexchange::Exchanges
  module Cryptology
    class Market < Cryptoexchange::Models::Market
      NAME = 'cryptology'
      API_URL = 'https://api.prod.cryptology.com/public/v1'
    end
  end
end
