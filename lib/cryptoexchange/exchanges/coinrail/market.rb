module Cryptoexchange::Exchanges
  module Coinrail
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinrail'
      API_URL = 'https://api.coinrail.co.kr'
      TICKER_URL = 'https://coinrail.co.kr/main/market_info'
    end
  end
end
