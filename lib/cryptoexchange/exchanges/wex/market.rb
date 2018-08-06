module Cryptoexchange::Exchanges
  module Wex
    class Market < Cryptoexchange::Models::Market
      NAME = 'wex'
      API_URL = 'https://wex.nz/api/3'

      def self.trade_page_url(args={})
        "https://wex.nz/exchange/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
