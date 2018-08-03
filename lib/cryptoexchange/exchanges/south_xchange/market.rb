module Cryptoexchange::Exchanges
  module SouthXchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'south_xchange'
      API_URL = 'https://www.southxchange.com/api'
    end
  end
end
