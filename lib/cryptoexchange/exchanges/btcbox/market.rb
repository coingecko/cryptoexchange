module Cryptoexchange::Exchanges
  module Btcbox
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcbox'
      API_URL = 'https://www.btcbox.co.jp/api/v1'
    end
  end
end
