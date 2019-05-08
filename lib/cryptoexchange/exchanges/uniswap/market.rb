module Cryptoexchange::Exchanges
  module Uniswap
    class Market < Cryptoexchange::Models::Market
      NAME = 'uniswap'
      API_URL = "https://api-test-238309.appspot.com/v0/exchanges?key"

      # Read the API key here
      authentication = Cryptoexchange::Exchanges::Uniswap::Authentication.new(
        :market,
        Cryptoexchange::Exchanges::Uniswap::Market::NAME
      )
      
      API_KEY = authentication.headers
    end
  end
end
