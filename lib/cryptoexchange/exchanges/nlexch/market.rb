module Cryptoexchange::Exchanges
  module Nlexch
    class Market < Cryptoexchange::Models::Market
      NAME = 'nlexch'
      API_URL = 'https://www.nlexch.com/api/v2'
    end
  end
end
