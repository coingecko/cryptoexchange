module Cryptoexchange::Exchanges
  module Nebula
    class Market < Cryptoexchange::Models::Market
      NAME = 'nebula'
      API_URL = 'https://api.nebula.exchange'
    end
  end
end
