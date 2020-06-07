module Cryptoexchange::Exchanges
  module DydxPerpetual
    class Market < Cryptoexchange::Models::Market
      NAME = 'dydx_perpetual'
      API_URL = 'https://api.dydx.exchange/v1'

      def self.trade_page_url(args={})
        "https://trade.dydx.exchange/perpetual/#{args[:inst_id]}"
      end
    end
  end
end
