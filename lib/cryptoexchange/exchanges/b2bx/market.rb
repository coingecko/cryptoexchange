module Cryptoexchange::Exchanges
  module B2bx
    class Market < Cryptoexchange::Models::Market
      NAME = 'b2bx'
      API_URL = 'https://api.b2bx.exchange/api/v1/b2trade/ticker'
    end
  end
end
