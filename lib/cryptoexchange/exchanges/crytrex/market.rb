module Cryptoexchange::Exchanges
  module Crytrex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'crytrex'
      API_URL = 'https://cryt.crytrex.com/public_api'
    end
  end
end
