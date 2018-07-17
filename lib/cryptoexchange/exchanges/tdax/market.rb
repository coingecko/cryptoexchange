module Cryptoexchange::Exchanges
  module Tdax
    class Market < Cryptoexchange::Models::Market
      NAME = 'tdax'
      API_URL = 'https://api.tdax.com'
    end
  end
end
