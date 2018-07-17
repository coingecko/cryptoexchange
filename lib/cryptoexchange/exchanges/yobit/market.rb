module Cryptoexchange::Exchanges
  module Yobit
    class Market < Cryptoexchange::Models::Market
      NAME = 'yobit'
      API_URL = 'https://yobit.net/api/3'
    end
  end
end
