module Cryptoexchange::Exchanges
  module Korbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'korbit'
      API_URL = 'https://api.korbit.co.kr/v1'
    end
  end
end
