module Cryptoexchange::Exchanges
  module Hikenex
    class Market < Cryptoexchange::Models::Market
      NAME = 'hikenex'
      API_URL = 'https://hikenex.com/remote/v1'
    end
  end
end
