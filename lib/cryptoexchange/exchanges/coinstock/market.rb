module Cryptoexchange::Exchanges
  module Coinstock
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinstock'
      API_URL = 'https://coinstock.me/api/v2'
    end
  end
end
