module Cryptoexchange::Exchanges
  module Exrates
    class Market < Cryptoexchange::Models::Market
      NAME='exrates'
      API_URL = 'https://exrates.me/public/coinmarketcap/ticker'
    end
  end
end