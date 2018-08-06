module Cryptoexchange::Exchanges
  module FirstGlobalCredit
    class Market < Cryptoexchange::Models::Market
      NAME = 'first_global_credit'
      API_URL = 'https://trading.firstglobalcredit.com/ticker'
    end
  end
end
