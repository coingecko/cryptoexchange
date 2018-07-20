module Cryptoexchange::Exchanges
  module Lykke
    class Market < Cryptoexchange::Models::Market
      NAME = 'lykke'
      API_URL = 'https://public-api.lykke.com/api'
    end
  end
end
