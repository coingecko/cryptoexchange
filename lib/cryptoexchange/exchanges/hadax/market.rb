module Cryptoexchange::Exchanges
  module Hadax
    class Market < Cryptoexchange::Models::Market
      NAME = 'hadax'
      PAIRS_API_URL = 'https://api.huobi.pro/v1/hadax/common/symbols'
      API_URL = 'https://api.hadax.com'
    end
  end
end
