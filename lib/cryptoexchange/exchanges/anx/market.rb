module Cryptoexchange::Exchanges
  module Anx
    class Market < Cryptoexchange::Models::Market
      NAME = 'anx'
      API_URL = 'https://anxpro.com/api/2'
    end
  end
end
