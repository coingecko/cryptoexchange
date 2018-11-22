module Cryptoexchange::Exchanges
  module AlienCloud
    class Market < Cryptoexchange::Models::Market
      NAME = 'alien_cloud'
      API_URL = 'https://aliencloud.xyz/api/1.0'

      def self.trade_page_url(args={})
        "https://aliencloud.xyz/en/trade/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
