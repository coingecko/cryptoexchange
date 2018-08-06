module Cryptoexchange::Exchanges
  module Zaif
    class Market < Cryptoexchange::Models::Market
      NAME = 'zaif'
      API_URL = 'https://api.zaif.jp/api/1'
    end
  end
end
