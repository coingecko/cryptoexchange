module Cryptoexchange::Exchanges
  module Bitker
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitker'
      API_URL = 'https://third.bitker.com/v1/api'
    end
  end
end
