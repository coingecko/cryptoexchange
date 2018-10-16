module Cryptoexchange::Exchanges
  module Ironex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ironex'
      API_URL = 'https://ironex.exchange'
    end
  end
end
