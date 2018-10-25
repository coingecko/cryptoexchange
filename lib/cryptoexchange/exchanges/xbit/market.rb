module Cryptoexchange::Exchanges
  module Xbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'xbit'
      API_URL = 'https://xbit.com.ec/api'
    end
  end
end