module Cryptoexchange::Exchanges
  module Coinpulse
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinpulse'
      API_URL = 'http://coinpulse.io/api/v1'
    end
  end
end
