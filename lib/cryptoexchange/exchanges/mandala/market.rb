module Cryptoexchange::Exchanges
  module Mandala
    class Market < Cryptoexchange::Models::Market
      NAME = 'mandala'
      API_URL = 'https://zapi.mandalaex.com'
    end
  end
end
