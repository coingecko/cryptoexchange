module Cryptoexchange::Exchanges
  module Coinhub
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinhub'
      API_URL = 'https://www.coinhub.io/en/gateway'
    end
  end
end
