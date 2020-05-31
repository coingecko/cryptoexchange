module Cryptoexchange::Exchanges
  module UniswapV1
    class Market < Cryptoexchange::Models::Market
      NAME = 'uniswap_v1'
      API_URL = "https://api.blocklytics.org/uniswap/v1"

      def self.api_key
        authentication = Cryptoexchange::Exchanges::UniswapV1::Authentication.new(
          :market,
          Cryptoexchange::Exchanges::UniswapV1::Market::NAME
        )
        authentication.validate_credentials!
        authentication.api_key
      end
    end
  end
end
