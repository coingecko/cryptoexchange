require 'pry'
module Cryptoexchange::Exchanges
  module Belfrics
    class Market < Cryptoexchange::Models::Market
      NAME = 'belfrics'
      API_URL = 'https://belfrics.io/belfrics/api/v1/public/all/marketdata'
    end
  end
end
