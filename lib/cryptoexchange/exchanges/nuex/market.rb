module Cryptoexchange::Exchanges
  module Nuex
    class Market < Cryptoexchange::Models::Market
      NAME = 'nuex'
      API_URL = 'https://api.nuex.com/api/v1'
    end
  end
end
