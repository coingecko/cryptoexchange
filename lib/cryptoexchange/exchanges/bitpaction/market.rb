module Cryptoexchange::Exchanges
  module Bitpaction
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitpaction'
      API_URL = 'https://api.bitpaction.com/api/v1'
    end
  end
end
