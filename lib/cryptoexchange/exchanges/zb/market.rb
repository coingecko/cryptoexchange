module Cryptoexchange::Exchanges
  module Zb
    class Market < Cryptoexchange::Models::Market
      NAME = 'zb'
      API_URL = 'http://api.zb.com/data/v1'
    end
  end
end
