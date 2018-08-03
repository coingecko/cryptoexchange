module Cryptoexchange::Exchanges
  module Coinbene
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinbene'
      API_URL = 'http://api.coinbene.com/v1'
    end
  end
end
