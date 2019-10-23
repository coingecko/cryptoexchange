module Cryptoexchange::Exchanges
  module Hpx
    class Market < Cryptoexchange::Models::Market
      NAME = 'hpx'
      API_URL = 'http://api.hpx.world/data/v2'
    end
  end
end
