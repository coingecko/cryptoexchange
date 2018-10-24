module Cryptoexchange::Exchanges
  module Deex
    class Market < Cryptoexchange::Models::Market
      NAME = 'deex'
      API_URL = 'https://stat-api.deex.exchange:2087'
    end
  end
end
