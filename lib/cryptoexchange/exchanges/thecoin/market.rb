module Cryptoexchange::Exchanges
  module Thecoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'thecoin'
      API_URL = 'https://trade.thecoin.pw/api/v1'
    end
  end
end
