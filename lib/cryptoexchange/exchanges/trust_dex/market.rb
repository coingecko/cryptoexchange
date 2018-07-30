module Cryptoexchange::Exchanges
  module TrustDex
    class Market < Cryptoexchange::Models::Market
      NAME = 'trust_dex'
      API_URL = 'https://trustdex.io/market/api'
    end
  end
end
