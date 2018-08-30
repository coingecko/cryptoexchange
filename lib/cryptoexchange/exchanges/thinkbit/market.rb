module Cryptoexchange::Exchanges
  module Thinkbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'thinkbit'
      API_URL = 'https://api.thinkbit.com/v2'
    end
  end
end
