module Cryptoexchange::Exchanges
  module Bitbay
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbay'
      API_URL = 'https://bitbay.net/API/Public'
    end
  end
end
