module Cryptoexchange::Exchanges
  module Incorex
    class Market < Cryptoexchange::Models::Market
      NAME = 'incorex'
      API_URL = 'https://api.incorex.com/v1'
    end
  end
end
