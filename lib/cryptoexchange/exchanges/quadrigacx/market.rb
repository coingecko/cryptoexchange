module Cryptoexchange::Exchanges
  module Quadrigacx
    class Market < Cryptoexchange::Models::Market
      NAME = 'quadrigacx'
      API_URL = 'https://api.quadrigacx.com/v2'
    end
  end
end
