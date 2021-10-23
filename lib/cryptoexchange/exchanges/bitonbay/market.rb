module Cryptoexchange::Exchanges
  module Bitonbay
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitonbay'
      API_URL = 'https://api.bitonbay.com/v1'
    end
  end
end
