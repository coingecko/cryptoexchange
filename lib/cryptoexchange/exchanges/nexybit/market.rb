module Cryptoexchange::Exchanges
  module Nexybit
    class Market < Cryptoexchange::Models::Market
      NAME = 'nexybit'
      API_URL = 'https://api.nexybit.com/api/spot/v1'
    end
  end
end
