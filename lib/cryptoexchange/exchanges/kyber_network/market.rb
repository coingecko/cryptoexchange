module Cryptoexchange::Exchanges
  module KyberNetwork
    class Market < Cryptoexchange::Models::Market
      NAME = 'kyber_network'
      API_URL = 'https://tracker.kyber.network/api'

      def self.trade_page_url(args={})
        "https://kyber.network/swap/#{args[:target]}_#{args[:base]}"
      end
    end
  end
end
