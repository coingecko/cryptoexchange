module Cryptoexchange::Exchanges
  module Gopax
    class Market < Cryptoexchange::Models::Market
      NAME = 'gopax'
      API_URL = 'https://api.gopax.co.kr'
    end
  end
end
