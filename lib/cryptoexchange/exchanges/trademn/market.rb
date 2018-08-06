module Cryptoexchange::Exchanges
  module Trademn
    class Market < Cryptoexchange::Models::Market
      NAME = 'trademn'
      API_URL = 'https://api.trade.mn/public'
    end
  end
end
