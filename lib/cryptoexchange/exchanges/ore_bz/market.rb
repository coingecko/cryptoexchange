module Cryptoexchange::Exchanges
  module OreBz
    class Market < Cryptoexchange::Models::Market
      NAME = 'ore_bz'
      API_URL = 'https://ore.bz:443/api/v2'
    end
  end
end
