module Cryptoexchange::Exchanges
  module Idcm
    class Market < Cryptoexchange::Models::Market
      NAME = 'idcm'
      API_URL = 'http://api.idcm.io:8303/api/v1'
    end
  end
end
