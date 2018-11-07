module Cryptoexchange::Exchanges
  module Ovis
    class Market < Cryptoexchange::Models::Market
      NAME = 'ovis'
      API_URL = 'https://api.ovis.com.tr/public'
    end
  end
end
