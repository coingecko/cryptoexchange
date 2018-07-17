module Cryptoexchange::Exchanges
  module Exmo
    class Market < Cryptoexchange::Models::Market
      NAME = 'exmo'
      API_URL = 'https://api.exmo.com/v1'
    end
  end
end
