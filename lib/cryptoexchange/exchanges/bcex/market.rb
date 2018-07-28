module Cryptoexchange::Exchanges
  module Bcex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bcex'
      API_URL = 'https://www.bcex.ca'
    end
  end
end
