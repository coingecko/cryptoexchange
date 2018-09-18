module Cryptoexchange::Exchanges
  module Coinplace
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinplace'
      API_URL = 'https://coinplace.pro/share/ticker.json'
    end
  end
end
