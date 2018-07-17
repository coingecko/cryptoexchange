module Cryptoexchange::Exchanges
  module CoinEgg
    class Market < Cryptoexchange::Models::Market
      NAME = 'coin_egg'
      API_URL = 'https://api.coinegg.com'
    end
  end
end
