module Cryptoexchange::Exchanges
  module Maplechange
    class Market < Cryptoexchange::Models::Market
      NAME = 'maplechange'
      API_URL = 'https://maplechange.com/api/v2'
    end
  end
end
