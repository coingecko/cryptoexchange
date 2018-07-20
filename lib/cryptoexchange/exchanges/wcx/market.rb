module Cryptoexchange::Exchanges
  module Wcx
    class Market < Cryptoexchange::Models::Market
      NAME    = 'wcx'
      API_URL = 'https://api.wcex.com'
    end
  end
end