module Cryptoexchange::Exchanges
  module Bitnaru
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitnaru'
      API_URL = 'https://market.bitnaru.com'

      def self.trade_page_url(args={})
        "https://www.bitnaru.com/exchange"
      end
    end
  end
end
