module Cryptoexchange::Exchanges
  module Btcmarkets
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcmarkets'
      API_URL = 'https://api.btcmarkets.net'
    end
  end
end
