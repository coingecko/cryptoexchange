module Cryptoexchange::Exchanges
  module Coinjar
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinjar'
      API_URL = 'https://data.exchange.coinjar.com/products'
    end
  end
end
