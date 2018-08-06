module Cryptoexchange::Exchanges
  module Therocktrading
    class Market < Cryptoexchange::Models::Market
      NAME = 'therocktrading'
      API_URL = 'https://www.therocktrading.com/api'
    end
  end
end
