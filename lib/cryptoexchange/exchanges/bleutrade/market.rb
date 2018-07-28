module Cryptoexchange::Exchanges
  module Bleutrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'bleutrade'
      API_URL = 'https://bleutrade.com/api/v2'
    end
  end
end
