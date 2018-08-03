module Cryptoexchange::Exchanges
  module Freiexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'freiexchange'
      API_URL = 'https://freiexchange.com/api'
    end
  end
end
