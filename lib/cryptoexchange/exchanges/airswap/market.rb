module Cryptoexchange::Exchanges
  module Airswap
    class Market < Cryptoexchange::Models::Market
      NAME = 'airswap'
      API_URL = 'https://maker-stats.production.airswap.io'
    end
  end
end
