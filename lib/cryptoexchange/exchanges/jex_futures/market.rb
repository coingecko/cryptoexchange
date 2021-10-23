module Cryptoexchange::Exchanges
  module JexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'jex_futures'
      API_URL = 'https://www.jex.com/api/v1'
    end
  end
end
