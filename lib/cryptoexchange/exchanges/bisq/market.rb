module Cryptoexchange::Exchanges
  module Bisq
    class Market < Cryptoexchange::Models::Market
      NAME = 'bisq'
      API_URL = 'https://markets.bisq.network/api'
    end
  end
end
