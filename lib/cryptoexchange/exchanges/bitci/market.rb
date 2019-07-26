module Cryptoexchange::Exchanges
  module Bitci
    class Market < Cryptoexchange::Models::Market
      NAME='bitci'
      API_URL = 'https://api.bitci.com/api'
    end
  end
end
