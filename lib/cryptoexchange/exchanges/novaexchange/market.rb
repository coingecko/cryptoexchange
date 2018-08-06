module Cryptoexchange::Exchanges
  module Novaexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'novaexchange'
      API_URL = 'https://novaexchange.com/remote/v2'
    end
  end
end
