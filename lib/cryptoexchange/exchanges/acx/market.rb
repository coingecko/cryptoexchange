module Cryptoexchange::Exchanges
  module Acx
    class Market < Cryptoexchange::Models::Market
      NAME = 'acx'
      API_URL = 'https://acx.io/api/v2'
    end
  end
end
