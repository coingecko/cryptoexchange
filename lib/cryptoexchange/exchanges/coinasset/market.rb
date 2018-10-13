module Cryptoexchange::Exchanges
  module Coinasset
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinasset'
      API_URL = 'https://api.coinasset.co.th/api/v1'
    end
  end
end
