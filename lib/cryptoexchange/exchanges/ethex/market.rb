module Cryptoexchange::Exchanges
  module Ethex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ethex'
      API_URL = 'https://api.ethex.market:5055'
    end
  end
end
