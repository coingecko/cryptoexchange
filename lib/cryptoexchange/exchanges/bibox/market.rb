module Cryptoexchange::Exchanges
  module Bibox
    class Market < Cryptoexchange::Models::Market
      NAME = 'bibox'
      API_URL = 'https://api.bibox.com/v1'
    end
  end
end
