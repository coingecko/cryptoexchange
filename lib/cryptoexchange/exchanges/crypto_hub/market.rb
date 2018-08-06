module Cryptoexchange::Exchanges
  module CryptoHub
    class Market < Cryptoexchange::Models::Market
      NAME = 'crypto_hub'
      API_URL = 'https://cryptohub.online/api'
    end
  end
end
