module Cryptoexchange::Exchanges
  module Lucent
    class Market < Cryptoexchange::Models::Market
      NAME = 'lucent'
      API_URL = 'https://lucent.exchange/api/v2'

      def self.trade_page_url(args={})
        "https://lucent.exchange/trading/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
