module Cryptoexchange::Exchanges
  module Bitbox
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbox'
      API_URL = 'https://api.bitbox.me/trade/public/v2'
    end
  end
end
