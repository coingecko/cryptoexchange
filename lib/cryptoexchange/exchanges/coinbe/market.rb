module Cryptoexchange::Exchanges
  module Coinbe
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinbe'
      API_URL = 'https://coinbe.net/public'
    end
  end
end
