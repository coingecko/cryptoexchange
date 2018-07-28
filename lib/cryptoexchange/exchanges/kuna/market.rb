module Cryptoexchange::Exchanges
  module Kuna
    class Market < Cryptoexchange::Models::Market
      NAME = 'kuna'
      API_URL = 'https://kuna.io/api/v2'
    end
  end
end
