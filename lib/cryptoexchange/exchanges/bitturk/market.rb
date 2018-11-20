module Cryptoexchange::Exchanges
  module Bitturk
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitturk'
      API_URL = 'https://api.bitturk.com/v1'
    end
  end
end
