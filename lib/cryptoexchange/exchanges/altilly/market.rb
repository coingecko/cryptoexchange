module Cryptoexchange::Exchanges
  module Altilly
    class Market < Cryptoexchange::Models::Market
      NAME = 'altilly'
      API_URL = 'https://api.altilly.com/api'
    end
  end
end
