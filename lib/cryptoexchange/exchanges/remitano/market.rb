module Cryptoexchange::Exchanges
  module Remitano
    class Market < Cryptoexchange::Models::Market
      NAME = 'remitano'
      API_URL = 'https://api.remitano.com/api/v1'

      def self.trade_page_url(args={})
        "https://remitano.com"
      end
    end
  end
end
