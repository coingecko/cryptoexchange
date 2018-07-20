module Cryptoexchange::Exchanges
  module Abcc
    class Market < Cryptoexchange::Models::Market
      NAME    = 'abcc'
      API_URL = 'https://api.abcc.com/api/v2'
    end
  end
end
