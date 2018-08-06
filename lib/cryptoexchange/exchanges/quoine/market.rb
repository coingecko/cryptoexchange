module Cryptoexchange::Exchanges
  module Quoine
    class Market < Cryptoexchange::Models::Market
      NAME = 'quoine'
      API_URL = 'https://api.quoine.com'
    end
  end
end
