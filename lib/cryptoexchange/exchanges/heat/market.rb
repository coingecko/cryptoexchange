module Cryptoexchange::Exchanges
  module Heat
    class Market
      NAME = 'heat'
      API_URL = 'https://heatwallet.com:7734/api/v1'
      TICKER_URL = "#{Cryptoexchange::Exchanges::Heat::Market::API_URL}/exchange/markets/all/change/true/0/1/0/100"
    end
  end
end
