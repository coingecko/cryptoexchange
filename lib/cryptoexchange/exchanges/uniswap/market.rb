module Cryptoexchange::Exchanges
  module Uniswap
    class Market < Cryptoexchange::Models::Market
      NAME = 'uniswap'
      API_URL = "https://api-test-238309.appspot.com/v0/exchanges?key"
      API_KEY = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
    end
  end
end
