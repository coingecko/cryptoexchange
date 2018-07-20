module Cryptoexchange::Exchanges
  module Ethfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ethfinex'
      API_URL = 'https://api.ethfinex.com'
    end
  end
end
