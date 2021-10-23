module Cryptoexchange::Exchanges
  module Exnce
    class Market < Cryptoexchange::Models::Market
      NAME = 'exnce'
      API_URL = 'https://exnce.com/api/v1'

      def self.trade_page_url(args={})
        "https://exnce.com/market/#{args[:base].upcase}-#{args[:target].upcase}"
      end
    end
  end
end
