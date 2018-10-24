module Cryptoexchange::Exchanges
  module Uex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'uex'
      API_URL = 'https://open-api.uex.com'
    end
  end
end
