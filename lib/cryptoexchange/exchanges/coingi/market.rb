module Cryptoexchange::Exchanges
  module Coingi
    class Market < Cryptoexchange::Models::Market
      NAME = 'coingi'
      API_URL = 'https://api.coingi.com'
    end
  end
end
