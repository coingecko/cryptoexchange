module Cryptoexchange::Exchanges
  module Bitkonan
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitkonan'
      API_URL = 'https://bitkonan.com/api'
    end
  end
end
