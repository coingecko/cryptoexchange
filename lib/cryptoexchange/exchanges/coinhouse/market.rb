module Cryptoexchange::Exchanges
  module Coinhouse
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinhouse'
      API_URL = 'https://coinhouse.eu/v2'
    end
  end
end
