module Cryptoexchange::Exchanges
  module Forkonex
    class Market < Cryptoexchange::Models::Market
      NAME = 'forkonex'
      API_URL = 'https://api.forkonex.com/v2'
    end
  end
end
