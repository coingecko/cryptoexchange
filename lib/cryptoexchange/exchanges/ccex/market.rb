module Cryptoexchange::Exchanges
  module Ccex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ccex'
      API_URL = 'https://c-cex.com/t'
    end
  end
end
