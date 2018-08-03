module Cryptoexchange::Exchanges
  module Openledger
    class Market < Cryptoexchange::Models::Market
      NAME = 'openledger'
      API_URL = 'https://stat-api.openledger.info/api/v1'
    end
  end
end