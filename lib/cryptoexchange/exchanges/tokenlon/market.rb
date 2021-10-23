module Cryptoexchange::Exchanges
  module Tokenlon
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokenlon'
      API_URL = 'https://tokenlon-core-market.tokenlon.im/rest'
    end
  end
end
