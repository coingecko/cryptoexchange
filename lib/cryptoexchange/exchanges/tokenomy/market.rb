module Cryptoexchange::Exchanges
  module Tokenomy
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokenomy'
      API_URL = 'https://exchange.tokenomy.com/api'
    end
  end
end
