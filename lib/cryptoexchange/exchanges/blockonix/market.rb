module Cryptoexchange::Exchanges
  module Blockonix
    class Market < Cryptoexchange::Models::Market
      NAME = 'blockonix'
      API_URL = 'https://dexserver.blockonix.com'
    end
  end
end
