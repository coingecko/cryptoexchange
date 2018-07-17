module Cryptoexchange::Exchanges
  module Coincheck
    class Market < Cryptoexchange::Models::Market
      NAME = 'coincheck'
      API_URL = 'https://coincheck.com/api'
    end
  end
end
