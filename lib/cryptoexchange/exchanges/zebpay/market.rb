module Cryptoexchange::Exchanges
  module Zebpay
    class Market < Cryptoexchange::Models::Market
      NAME = 'zebpay'
      API_URL = 'https://www.zebapi.com/pro/v1'
    end
  end
end
