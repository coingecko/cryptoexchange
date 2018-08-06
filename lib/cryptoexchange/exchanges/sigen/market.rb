module Cryptoexchange::Exchanges
  module Sigen
    class Market < Cryptoexchange::Models::Market
      NAME = 'sigen'
      API_URL = 'https://sigen.pro/v1/web-public/statistic'
    end
  end
end
