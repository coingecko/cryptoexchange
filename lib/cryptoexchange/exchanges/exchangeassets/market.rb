module Cryptoexchange::Exchanges
  module Exchangeassets
    class Market < Cryptoexchange::Models::Market
      NAME = 'exchangeassets'
      API_URL = 'https://exchange-assets.com/api/public'
    end
  end
end
