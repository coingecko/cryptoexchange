module Cryptoexchange::Exchanges
  module Tidebit
    class Market < Cryptoexchange::Models::Market
      NAME = 'tidebit'
      API_URL = 'https://www.tidebit.com/api/v2'
    end
  end
end
