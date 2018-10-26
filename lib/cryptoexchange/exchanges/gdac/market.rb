module Cryptoexchange::Exchanges
  module Gdac
    class Market < Cryptoexchange::Models::Market
      NAME    = 'gdac'
      API_URL = 'https://marketapi.gdac.co.kr/v1'
    end
  end
end
