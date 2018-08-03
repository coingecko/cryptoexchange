module Cryptoexchange::Exchanges
  module Yunbi
    class Market < Cryptoexchange::Models::Market
      NAME = 'yunbi'
      API_URL = 'https://yunbi.com/api/v2'
    end
  end
end
