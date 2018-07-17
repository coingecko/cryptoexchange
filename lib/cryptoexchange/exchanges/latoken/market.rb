module Cryptoexchange::Exchanges
  module Latoken
    class Market < Cryptoexchange::Models::Market
      NAME = 'latoken'
      API_URL = 'https://api.latoken.com'
    end
  end
end
