module Cryptoexchange::Exchanges
  module Bitinfi
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitinfi'
      API_URL = 'https://hq.bitinfi.com/v1'
    end
  end
end
