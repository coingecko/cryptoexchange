module Cryptoexchange::Exchanges
  module Dydx
    class Market < Cryptoexchange::Models::Market
      NAME = 'dydx'
      API_URL = 'https://api.dydx.exchange/v1'

      def self.trade_page_url(args={})
        "https://trade.dydx.exchange/markets"
      end
    end
  end
end
