module Cryptoexchange::Exchanges
  module Coinsuper
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinsuper'
      API_URL = 'https://www.coinsuper.com/v1/api'
    end
  end
end
