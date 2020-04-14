module Cryptoexchange::Exchanges
  module Crytrex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'crytrex'
      API_URL = 'https://crytrex.com/public_api'

      def self.trade_page_url(args={})
        "https://crytrex.com/markets"
      end
    end
  end
end
