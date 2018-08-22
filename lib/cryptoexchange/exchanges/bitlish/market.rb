module Cryptoexchange::Exchanges
  module Bitlish
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitlish'
      API_URL = 'https://bitlish.com/api/v1'
    end
  end
end
