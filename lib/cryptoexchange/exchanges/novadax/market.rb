module Cryptoexchange::Exchanges
  module Novadax
    class Market < Cryptoexchange::Models::Market
      NAME = 'novadax'
      API_URL = 'https://api.novadax.com/v1'
    end
  end
end
