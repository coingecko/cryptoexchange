module Cryptoexchange::Exchanges
  module Zbg
    class Market < Cryptoexchange::Models::Market
      NAME = 'zbg'
      API_URL = 'https://kline.zbg.com/api/data/v1'
    end
  end
end
