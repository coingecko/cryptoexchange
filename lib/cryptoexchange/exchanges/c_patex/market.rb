module Cryptoexchange::Exchanges
  module CPatex
    class Market < Cryptoexchange::Models::Market
      NAME = 'c_patex'
      API_URL = 'https://c-patex.com:443/api/v2'
    end
  end
end