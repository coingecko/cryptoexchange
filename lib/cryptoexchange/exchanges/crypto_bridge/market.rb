module Cryptoexchange::Exchanges
  module CryptoBridge
    class Market < Cryptoexchange::Models::Market
      NAME = 'crypto_bridge'
      API_URL = 'https://api.crypto-bridge.org/api/v1'

      def self.trade_page_url(args={})
        "https://wallet.crypto-bridge.org/market/BRIDGE.#{args[:base]}_BRIDGE.#{args[:target]}"
      end
    end
  end
end
