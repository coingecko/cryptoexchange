module Cryptoexchange::Exchanges
  module DydxPerpetual
    class Market < Cryptoexchange::Models::Market
      NAME = 'dydx_perpetual'
      API_URL = 'https://api.dydx.exchange/v1'

      def self.trade_page_url(args={})
        base = if args[:base] == "PBTC"
          "BTC"
        else
          args[:base]
        end

        "https://trade.dydx.exchange/perpetual/#{base}-#{args[:target]}"
      end
    end
  end
end
