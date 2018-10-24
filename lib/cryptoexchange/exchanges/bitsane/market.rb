module Cryptoexchange::Exchanges
  module Bitsane
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitsane'
      API_URL = 'https://bitsane.com/api/public'
    end
  end
end
