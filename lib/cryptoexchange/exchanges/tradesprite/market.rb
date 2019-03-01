module Cryptoexchange::Exchanges
  module Tradesprite
    class Market < Cryptoexchange::Models::Market
      NAME = 'tradesprite'
      API_URL = 'https://alpha.tradesprite.com/hydrasocket/v2'
    end
  end
end
