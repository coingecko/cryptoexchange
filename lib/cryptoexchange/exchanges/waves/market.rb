module Cryptoexchange::Exchanges
  module Waves
    class Market < Cryptoexchange::Models::Market
      NAME    = 'waves'
      API_URL = 'https://marketdata.wavesplatform.com/api'
    end
  end
end