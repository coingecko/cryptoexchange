module Cryptoexchange::Exchanges
  module Coinfalcon
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinfalcon'
      API_URL = 'https://coinfalcon.com/api/v1/'
    end
  end
end
