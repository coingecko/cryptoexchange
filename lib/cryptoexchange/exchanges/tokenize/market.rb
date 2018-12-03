module Cryptoexchange::Exchanges
  module Tokenize
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokenize'
      API_URL = 'https://api2.tokenize.exchange/api'
    end
  end
end
