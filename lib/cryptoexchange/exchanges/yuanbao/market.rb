module Cryptoexchange::Exchanges
  module Yuanbao
    class Market < Cryptoexchange::Models::Market
      NAME = 'yuanbao'
      API_URL = 'https://www.yuanbao.com/api_market/getinfo_cny/coin'
    end
  end
end
