module Cryptoexchange::Exchanges
  module MercadoBitcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'mercado_bitcoin'
      API_URL = 'https://www.mercadobitcoin.net/api'
    end
  end
end
