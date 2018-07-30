module Cryptoexchange::Exchanges
  module Kraken
    class Market < Cryptoexchange::Models::Market
      NAME = 'kraken'
      API_URL = 'https://api.kraken.com/0/public'
    end
  end
end
