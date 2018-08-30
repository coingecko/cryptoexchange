module Cryptoexchange::Exchanges
  module Instantbitex
    class Market < Cryptoexchange::Models::Market
      NAME = 'instantbitex'
      API_URL = 'https://api.instantbitex.com'
    end
  end
end
