module Cryptoexchange::Exchanges
  module Hotbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'hotbit'
      API_URL = 'https://api.hotbit.io/api/v1'
    end
  end
end