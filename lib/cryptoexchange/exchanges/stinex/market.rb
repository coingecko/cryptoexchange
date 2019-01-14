module Cryptoexchange::Exchanges
  module Stinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'stinex'
      API_URL = 'https://api.stinex.net/api/v2'

      def self.trade_page_url(args={})
        "https://api.stinex.net/trading/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
