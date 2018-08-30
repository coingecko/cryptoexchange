module Cryptoexchange::Exchanges
  module Dextop
    class Market < Cryptoexchange::Models::Market
      NAME = 'dextop'
      API_URL = 'http://dex.top/v1'
    end
  end
end
