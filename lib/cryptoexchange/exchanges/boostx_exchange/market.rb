module Cryptoexchange::Exchanges
  module BoostxExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'boostx_exchange'
      API_URL = 'https://boostxexchange.com/api/public?command'
    end
  end
end
