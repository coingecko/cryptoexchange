module Cryptoexchange::Exchanges
  module Ccore
    class Market < Cryptoexchange::Models::Market
      NAME = 'ccore'
      API_URL = 'https://websitewebapi.ccore.io'
    end
  end
end
