module Cryptoexchange::Exchanges
  module Dakuce
    class Market < Cryptoexchange::Models::Market
      NAME = 'dakuce'
      API_URL = 'https://dakuce.com/api/v1.0/public'
    end
  end
end
