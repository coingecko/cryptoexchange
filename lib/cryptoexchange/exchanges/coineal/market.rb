module Cryptoexchange::Exchanges
  module Coineal
    class Market < Cryptoexchange::Models::Market
      NAME = 'coineal'
      API_URL = 'https://exchange-open-api.coineal.com/open/api'
    end
  end
end
