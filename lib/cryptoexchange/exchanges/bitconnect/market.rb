module Cryptoexchange::Exchanges
  module Bitconnect
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitconnect'
      API_URL = 'https://bitconnect.co/api'
    end
  end
end
