module Cryptoexchange::Exchanges
  module Bitso
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitso'
      API_URL = 'https://api-dev.bitso.com/v3'
    end
  end
end
