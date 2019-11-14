module Cryptoexchange::Exchanges
  module Vebitcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'vebitcoin'
      API_URL = 'https://us-central1-vebitcoin-market.cloudfunctions.net'
    end
  end
end
