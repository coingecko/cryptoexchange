module Cryptoexchange::Exchanges
  module BitcoinIndonesia
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitcoin_indonesia'
      API_URL = 'https://vip.bitcoin.co.id/api'
    end
  end
end
