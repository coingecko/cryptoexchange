module Cryptoexchange::Exchanges
  module Ccx
    class Market < Cryptoexchange::Models::Market
      NAME = 'ccx'
      API_URL = 'https://manager.ccxcanada.com/api/v2'
      
    end
  end
end
