module Cryptoexchange::Exchanges
  module XbtPrime
    class Market < Cryptoexchange::Models::Market
      NAME = 'xbt_prime'
      API_URL = 'https://api.primexbt.com/v1'
    end
  end
end
