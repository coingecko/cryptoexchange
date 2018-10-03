module Cryptoexchange::Exchanges
  module Bcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'bcoin'.freeze
      API_URL = 'https://www.bcoin.sg/v1/api/market/hour24Market'.freeze
    end
  end
end
