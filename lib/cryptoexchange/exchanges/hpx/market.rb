module Cryptoexchange::Exchanges
  module Hpx
    class Market < Cryptoexchange::Models::Market
      NAME = 'hpx'
      API_URL = 'https://api.hpx.com/data/v2'
    end
  end
end
