module Cryptoexchange::Exchanges
  module Fisco
    class Market < Cryptoexchange::Models::Market
      NAME = 'fisco'
      API_URL = 'https://api.fcce.jp/api/1'
    end
  end
end
