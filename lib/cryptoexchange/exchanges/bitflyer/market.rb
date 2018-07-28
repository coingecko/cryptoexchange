module Cryptoexchange::Exchanges
  module Bitflyer
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitflyer'
      API_URL = 'https://api.bitflyer.jp/v1'
    end
  end
end
