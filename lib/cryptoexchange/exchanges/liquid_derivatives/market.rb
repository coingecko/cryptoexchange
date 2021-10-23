module Cryptoexchange::Exchanges
  module LiquidDerivatives
    class Market < Cryptoexchange::Models::Market
      NAME = 'liquid_derivatives'
      API_URL = 'https://api.liquid.com'

      def self.trade_page_url(args={})
        "https://app.liquid.com/perpetual/#{args[:inst_id]}"
      end

      def self.get_id(target)
        output = JSON.parse HTTP.get("https://api.liquid.com/products?perpetual=1")
        id = output.select { |o| o["quoted_currency"] == target }.first["id"]
      end
    end
  end
end
