module Cryptoexchange::Exchanges
  module Vertpig
    class Market < Cryptoexchange::Models::Market
      NAME = 'vertpig'
      API_URL = 'https://www.vertpig.com/api/v1.1'
    end
  end
end
