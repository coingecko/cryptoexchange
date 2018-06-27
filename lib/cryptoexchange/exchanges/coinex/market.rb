module Cryptoexchange::Exchanges
  module Coinex
    class Market
      NAME = 'coinex'
      API_URL = 'https://api.coinex.com/v1'
      SEPARATOR_REGEX = /(USDT|BTC|BCH|ETH)\z/
    end
  end
end
