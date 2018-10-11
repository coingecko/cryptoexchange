module Cryptoexchange::Exchanges
  module Cashierest
    class Market < Cryptoexchange::Models::Market
      NAME = 'cashierest'
      API_URL = 'https://rest.cashierest.com/public'
    end
  end
end
