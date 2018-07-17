module Cryptoexchange::Exchanges
  module Paymium
    class Market < Cryptoexchange::Models::Market
      NAME = 'paymium'
      API_URL = 'https://paymium.com/api/v1'
    end
  end
end
