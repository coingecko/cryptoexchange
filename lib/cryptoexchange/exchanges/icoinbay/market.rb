module Cryptoexchange::Exchanges
  module Icoinbay
    class Market < Cryptoexchange::Models::Market
      NAME = 'icoinbay'
      API_URL = 'http://api.icoinbay.com/api'
    end
  end
end
