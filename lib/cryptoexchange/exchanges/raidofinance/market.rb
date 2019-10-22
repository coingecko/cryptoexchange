module Cryptoexchange::Exchanges
  module Raidofinance
    class Market < Cryptoexchange::Models::Market
      NAME = 'raidofinance'
      API_URL = 'https://datacenter.raidofinance.eu/v1'
    end
  end
end
