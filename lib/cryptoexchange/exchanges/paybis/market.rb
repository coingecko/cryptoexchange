module Cryptoexchange::Exchanges
  module Paybis
    class Market < Cryptoexchange::Models::Market
      NAME = 'paybis'
      API_URL = 'https://paybis.com'
    end
  end
end
