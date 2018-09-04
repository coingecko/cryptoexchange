module Cryptoexchange::Exchanges
  module Bitbox
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbox'
      API_URL = 'https://openapi.bitbox.me/v1/market/public/'
    end
  end
end
