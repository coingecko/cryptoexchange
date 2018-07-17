module Cryptoexchange::Exchanges
  module Crex24
    class Market < Cryptoexchange::Models::Market
      NAME = 'crex24'
      API_URL = 'https://api.crex24.com/CryptoExchangeService/BotPublic'
    end
  end
end
