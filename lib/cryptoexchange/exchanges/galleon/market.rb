module Cryptoexchange::Exchanges
  module Galleon
    class Market < Cryptoexchange::Models::Market
      NAME = 'galleon'
      API_URL = 'https://galleon.exchange/api/v2'

      def self.trade_page_url(args={})
        "https://galleon.exchange/trading/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
