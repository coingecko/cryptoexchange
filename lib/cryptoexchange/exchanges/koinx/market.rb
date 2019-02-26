module Cryptoexchange::Exchanges
  module Koinx
    class Market < Cryptoexchange::Models::Market
      NAME = 'koinx'
      API_URL = 'https://koinx.id/api'

      def self.trade_page_url(args={})
        "https://koinx.id/exchange/#{args[:base].upcase}/#{args[:target].upcase}"
      end
    end
  end
end
