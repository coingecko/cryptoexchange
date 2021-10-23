module Cryptoexchange::Exchanges
  module Beaxy
    class Market < Cryptoexchange::Models::Market
      NAME    = 'beaxy'
      API_URL = 'https://services.beaxy.com/api/v2'

      def self.trade_page_url(args = {})
        "https://www.beaxy.com/trading-pair/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
