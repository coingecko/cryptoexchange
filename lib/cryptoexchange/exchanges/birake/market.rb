module Cryptoexchange::Exchanges
  module Birake
    class Market < Cryptoexchange::Models::Market
      NAME = 'birake'
      API_URL = 'https://api.birake.com'

      def self.trade_page_url(args={})
        "https://birake.com/trade/BIRAKE.#{args[:base]}_BIRAKE.#{args[:target]}"
      end
    end
  end
end
