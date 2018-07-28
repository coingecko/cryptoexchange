module Cryptoexchange::Exchanges
  module Coinmate
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinmate'
      API_URL = 'https://coinmate.io/api'
    end
  end
end
