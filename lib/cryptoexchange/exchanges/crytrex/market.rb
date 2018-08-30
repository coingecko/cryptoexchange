module Cryptoexchange::Exchanges
  module Crytrex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'crytrex'
      API_URL = 'https://crytrex.com/public_api'
    end
  end
end
