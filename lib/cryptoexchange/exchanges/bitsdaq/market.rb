module Cryptoexchange::Exchanges
  module Bitsdaq
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitsdaq'
      API_URL = 'https://bitsdaq.com/api'

      def self.trade_page_url(args={})
        "https://bitsdaq.com/exchange/#{args[:base].upcase}-#{args[:target].upcase}"
      end
    end
  end
end
