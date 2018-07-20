module Cryptoexchange::Exchanges
  module Lakebtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'lakebtc'
      API_URL = 'https://api.lakebtc.com/api_v2'
    end
  end
end
