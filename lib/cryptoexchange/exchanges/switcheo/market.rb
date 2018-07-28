module Cryptoexchange::Exchanges
  module Switcheo
    class Market < Cryptoexchange::Models::Market
      NAME = 'switcheo'
      API_URL = 'https://api.switcheo.network'
    end
  end
end
