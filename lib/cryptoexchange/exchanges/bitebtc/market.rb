module Cryptoexchange::Exchanges
  module Bitebtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitebtc'
      API_URL = 'https://bitebtc.com/api/v1'
    end
  end
end
