module Cryptoexchange::Exchanges
  module Btcsquare
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcsquare'
      API_URL = 'https://www.btcsquare.net/api/v1'
    end
  end
end
