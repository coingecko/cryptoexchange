module Cryptoexchange::Exchanges
  module Hitbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'hitbtc'
      API_URL = 'https://api.hitbtc.com/api/2'

      def self.trade_page_url(args={})
        "https://hitbtc.com/#{args[:base].upcase}-to-#{args[:target].upcase}"
      end
    end
  end
end
