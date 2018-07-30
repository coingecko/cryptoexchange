module Cryptoexchange::Exchanges
  module Upbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'upbit'
      API_URL = 'https://api.upbit.com/v1'
    end
  end
end
