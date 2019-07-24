module Cryptoexchange::Exchanges
  module DarbFinance
    class Market < Cryptoexchange::Models::Market
      NAME = 'darb_finance'
      API_URL = 'https://api.darbfinance.com/api/v1'
    end
  end
end
