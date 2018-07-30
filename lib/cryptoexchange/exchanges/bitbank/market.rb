module Cryptoexchange::Exchanges
  module Bitbank
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbank'
      API_URL = 'https://public.bitbank.cc'
    end
  end
end
