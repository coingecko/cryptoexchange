module Cryptoexchange::Exchanges
  module Paroexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'paroexchange'
      API_URL = 'https://paroexchange-front-api-php.azurewebsites.net'
    end
  end
end
