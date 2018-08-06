module Cryptoexchange::Exchanges
  module Livecoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'livecoin'
      API_URL = 'https://api.livecoin.net'
    end
  end
end
