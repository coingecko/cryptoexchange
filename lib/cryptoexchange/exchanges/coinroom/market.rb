module Cryptoexchange::Exchanges
  module Coinroom
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinroom'
      API_URL = 'https://coinroom.com/api'
    end
  end
end
