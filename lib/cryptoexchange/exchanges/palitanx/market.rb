module Cryptoexchange::Exchanges
  module Palitanx
    class Market < Cryptoexchange::Models::Market
      NAME = 'palitanx'
      API_URL = 'https://api.palitanx.com/v1/public'
    end
  end
end
