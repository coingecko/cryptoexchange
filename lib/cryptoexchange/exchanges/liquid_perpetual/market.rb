module Cryptoexchange::Exchanges
  module LiquidPerpetual
    class Market < Cryptoexchange::Models::Market
      NAME = 'liquid_perpetual'
      API_URL = 'https://api.liquid.com'

      def self.trade_page_url(args={})
        "https://app.liquid.com/perpetual"
      end
    end
  end
end
