module Cryptoexchange::Exchanges
  module Cpdax
    class Market < Cryptoexchange::Models::Market
      NAME = 'cpdax'
      API_URL = 'https://api.cpdax.com/v1'
    end
  end
end
