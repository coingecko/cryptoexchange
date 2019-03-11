module Cryptoexchange::Exchanges
  module Dextrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'Dextrade'
      API_URL = 'https://api.dex-trade.com/v1/coingecko'
    end
  end
end
