module Cryptoexchange::Exchanges
  module Allcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'allcoin'
      API_URL = 'https://api.allcoin.com/api/v1'
    end
  end
end
