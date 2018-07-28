module Cryptoexchange::Exchanges
  module Itbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'itbit'
      API_URL = 'https://api.itbit.com/v1'
    end
  end
end
