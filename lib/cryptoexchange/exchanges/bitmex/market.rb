module Cryptoexchange::Exchanges
  module Bitmex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitmex'
      API_URL = 'https://www.bitmex.com/api/v1'
    end
  end
end
