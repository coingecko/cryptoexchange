module Cryptoexchange::Exchanges
  module Sapotaexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'sapotaexchange'
      API_URL = 'https://sapotaexchange.com/api/1'
    end
  end
end
