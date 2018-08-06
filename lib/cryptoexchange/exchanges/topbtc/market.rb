module Cryptoexchange::Exchanges
  module Topbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'topbtc'
      API_URL = 'http://www.topbtc.one/market/tickerall.php'
    end
  end
end
