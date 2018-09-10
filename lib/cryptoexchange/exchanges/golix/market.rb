module Cryptoexchange::Exchanges
  module Golix
    class Market < Cryptoexchange::Models::Market
      NAME = 'golix'
      API_URL = 'https://golix.com/api/v1'
    end
  end
end
