module Cryptoexchange::Exchanges
  module Gdax
    class Market < Cryptoexchange::Models::Market
      NAME = 'gdax'
      API_URL = 'https://api.gdax.com'
    end
  end
end
