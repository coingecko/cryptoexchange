module Cryptoexchange::Exchanges
  module Coinsquare
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinsquare'
      API_URL = 'https://api.coinsquare.solutions/platform/internal/v1'
    end
  end
end
