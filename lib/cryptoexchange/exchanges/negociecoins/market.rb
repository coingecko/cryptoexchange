module Cryptoexchange::Exchanges
  module Negociecoins
    class Market < Cryptoexchange::Models::Market
      NAME = 'negociecoins'
      API_URL = 'https://broker.negociecoins.com.br/api/v3'
    end
  end
end
