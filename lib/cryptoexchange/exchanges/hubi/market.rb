module Cryptoexchange::Exchanges
  module Hubi
    class Market < Cryptoexchange::Models::Market
      NAME = 'hubi'
      API_URL = 'https://www.hubi.com/api/v1'
    end
  end
end
