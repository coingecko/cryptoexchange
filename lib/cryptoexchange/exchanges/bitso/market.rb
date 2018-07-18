module Cryptoexchange::Exchanges
  module Bitso
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitso'
      API_URL = 'https://api.bitso.com/v3'
    end
  end
end
