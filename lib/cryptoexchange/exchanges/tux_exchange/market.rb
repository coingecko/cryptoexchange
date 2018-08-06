module Cryptoexchange::Exchanges
  module TuxExchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'tux_exchange'
      API_URL = 'https://tuxexchange.com/api'
    end
  end
end
