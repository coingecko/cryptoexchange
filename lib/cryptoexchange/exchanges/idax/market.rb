module Cryptoexchange::Exchanges
  module Idax
    class Market < Cryptoexchange::Models::Market
      NAME = 'idax'
      API_URL = 'https://www.idax.mn/api/Signalr'
    end
  end
end
