module Cryptoexchange::Exchanges
  module TraderOne
    class Market < Cryptoexchange::Models::Market
      NAME = 'trader_one'
      API_URL = 'https://api.traderone.exchange'
    end
  end
end
