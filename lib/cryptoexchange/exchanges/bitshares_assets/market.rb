module Cryptoexchange::Exchanges
  module BitsharesAssets
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitshares_assets'
      API_URL = 'https://cryptofresh.com/api'
    end
  end
end
