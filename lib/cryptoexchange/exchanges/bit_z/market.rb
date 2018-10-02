module Cryptoexchange::Exchanges
  module BitZ
    class Market < Cryptoexchange::Models::Market
      NAME = 'bit_z'
      API_URL = "https://apiv2.bitz.com".freeze
    end
  end
end
