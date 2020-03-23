module Cryptoexchange::Exchanges
  module Bancor
    class Market < Cryptoexchange::Models::Market
      NAME = 'bancor'
      API_URL = 'https://api.bancor.network/0.1'
    end
  end
end
