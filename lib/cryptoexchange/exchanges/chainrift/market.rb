module Cryptoexchange::Exchanges
  module Chainrift
    class Market < Cryptoexchange::Models::Market
      NAME = 'chainrift'
      API_URL = 'https://api.chainrift.com/v1'
    end
  end
end
