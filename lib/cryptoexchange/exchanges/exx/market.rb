module Cryptoexchange::Exchanges
  module Exx
    class Market < Cryptoexchange::Models::Market
      NAME = 'exx'
      API_URL = 'https://api.exx.com/data/v1'
    end
  end
end
