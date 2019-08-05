module Cryptoexchange::Exchanges
  module Ovex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ovex'
      API_URL = 'https://www.ovex.io/api/v2'

      def self.trade_page_url(args={})
        "https://www.ovex.io/trading/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
