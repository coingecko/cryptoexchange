module Cryptoexchange::Exchanges
  module Uniswap
    class Market < Cryptoexchange::Models::Market
      NAME = 'uniswap'
      API_KEY = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
      API_URL = "https://api-test-238309.appspot.com/v0/exchanges?key=#{API_KEY}"
    end
  end
end
