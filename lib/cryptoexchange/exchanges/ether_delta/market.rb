module Cryptoexchange::Exchanges
  module EtherDelta
    class Market < Cryptoexchange::Models::Market
      NAME = 'ether_delta'
      API_URL = 'https://api.etherdelta.com'
    end
  end
end
