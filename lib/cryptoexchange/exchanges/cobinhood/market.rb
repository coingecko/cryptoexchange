module Cryptoexchange::Exchanges
  module Cobinhood
    class Market < Cryptoexchange::Models::Market
      NAME = 'cobinhood'
      API_URL = 'https://api.cobinhood.com/v1'
    end
  end
end
