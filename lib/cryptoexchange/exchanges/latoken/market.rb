module Cryptoexchange::Exchanges
  module Latoken
    class Market < Cryptoexchange::Models::Market
      NAME = 'latoken'
      API_URL = 'https://api.latoken.com/v2'

      def self.trade_page_url(args={})
        "https://latoken.com/exchange/#{args[:target].upcase}-#{args[:base].upcase}"
      end
    end
  end
end
