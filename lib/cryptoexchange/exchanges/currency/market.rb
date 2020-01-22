module Cryptoexchange::Exchanges
  module Currency
    class Market < Cryptoexchange::Models::Market
      NAME = 'currency'
      API_URL = 'https://marketcap.backend.currency.com'
    end
  end
end
