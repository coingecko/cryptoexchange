module Cryptoexchange::Exchanges
  module Oasisdex
    class Market < Cryptoexchange::Models::Market
      NAME = 'oasisdex'
      API_URL = 'http://api.oasisdex.com/v1'
    end
  end
end
