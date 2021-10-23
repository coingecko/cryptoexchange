module Cryptoexchange::Exchanges
  module KyberNetwork
    class Market < Cryptoexchange::Models::Market
      NAME = 'kyber_network'
      API_URL = 'https://api.kyber.network'

      def self.trade_page_url(args={})
        "https://kyberswap.com/swap/#{args[:target].downcase}-#{args[:base].downcase}"
      end
    end
  end
end
