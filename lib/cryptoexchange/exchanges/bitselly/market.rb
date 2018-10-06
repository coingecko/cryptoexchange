module Cryptoexchange::Exchanges
  module Bitselly
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitselly'
      API_URL = 'https://api.bitselly.com/api/v1/public'
    end
  end
end
