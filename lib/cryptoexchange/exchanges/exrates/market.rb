module Cryptoexchange::Exchanges
  module Exrates
    class Market < Cryptoexchange::Models::Market
      NAME='exrates'
      API_URL = 'https://api.exrates.me/openapi/v1/public'

      def self.trade_page_url(args={})
        "https://exrates.me/dashboard"
      end
    end
  end
end