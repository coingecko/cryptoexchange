module Cryptoexchange::Exchanges
  module Extstock
    class Market < Cryptoexchange::Models::Market
      NAME = 'extstock'
      API_URL = 'https://extstock.com/api/v1'
    end
  end
end
