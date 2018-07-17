module Cryptoexchange::Exchanges
  module Octaex
    class Market < Cryptoexchange::Models::Market
      NAME = 'octaex'
      API_URL = 'https://octaex.com/api/trade'
    end
  end
end
