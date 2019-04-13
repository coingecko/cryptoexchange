module Cryptoexchange::Exchanges
  module Indodax
    class Market < Cryptoexchange::Models::Market
      NAME = 'indodax'
      API_URL = 'https://indodax.com/api'
    end
  end
end
