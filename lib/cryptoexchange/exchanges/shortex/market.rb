module Cryptoexchange::Exchanges
  module Shortex
    class Market < Cryptoexchange::Models::Market
      NAME = 'shortex'
      API_URL = 'https://api.shortex.net/api/v2'

      def self.trade_page_url(args={})
        "https://api.shortex.net/trading/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
