module Cryptoexchange::Exchanges
  module Novadex
    class Market < Cryptoexchange::Models::Market
      NAME = 'novadex'
      API_URL = 'https://novadex.io'
    end
  end
end
