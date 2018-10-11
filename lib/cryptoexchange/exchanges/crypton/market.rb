module Cryptoexchange::Exchanges
  module Crypton
    class Market < Cryptoexchange::Models::Market
      NAME = 'crypton'
      API_URL = 'https://api.cryptonbtc.com'
    end
  end
end
