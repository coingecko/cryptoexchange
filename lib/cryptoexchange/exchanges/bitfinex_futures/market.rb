module Cryptoexchange::Exchanges
  module BitfinexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitfinex_futures'
      API_URL = 'https://api-pub.bitfinex.com/v2'
    end
  end
end
