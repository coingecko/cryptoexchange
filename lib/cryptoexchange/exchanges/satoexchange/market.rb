module Cryptoexchange::Exchanges
  module Satoexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'satoexchange'
      API_URL = 'https://www.satoexchange.com/api/v1'
    end
  end
end
