module Cryptoexchange::Exchanges
  module Unidax
    class Market < Cryptoexchange::Models::Market
      NAME = 'unidax'
      API_URL = 'https://api.unidax.com/open/api'

      def self.trade_page_url(args={})
        "https://www.unidax.com/trade"
      end
    end
  end
end
