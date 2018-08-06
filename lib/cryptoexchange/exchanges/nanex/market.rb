module Cryptoexchange::Exchanges
  module Nanex
    class Market < Cryptoexchange::Models::Market
      NAME = 'nanex'
      API_URL = 'https://nanex.co/api'
    end
  end
end
