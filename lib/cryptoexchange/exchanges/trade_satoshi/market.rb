module Cryptoexchange::Exchanges
  module TradeSatoshi
    class Market < Cryptoexchange::Models::Market
      NAME = 'trade_satoshi'
      API_URL = 'https://tradesatoshi.com/api/public'
    end
  end
end
