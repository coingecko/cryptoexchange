module Cryptoexchange::Exchanges
  module B2bx
    class Market < Cryptoexchange::Models::Market
      NAME = 'b2bx'
      API_URL = 'https://cryptottlivewebapi.b2bx.exchange:8443/api/v1'
    end
  end
end
