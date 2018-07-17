module Cryptoexchange::Exchanges
  module KyberNetwork
    class Market < Cryptoexchange::Models::Market
      NAME = 'kyber_network'
      API_URL = 'https://tracker.kyber.network/api'
    end
  end
end
