module Cryptoexchange::Exchanges
  module Omnitrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'omnitrade'
      API_URL = 'https://omnitrade.io/api/v2'
    end
  end
end
