module Cryptoexchange::Exchanges
  module Lucent
    class Market < Cryptoexchange::Models::Market
      NAME = 'lucent'
      API_URL = 'https://lucent.exchange/api/v2'
    end
  end
end

