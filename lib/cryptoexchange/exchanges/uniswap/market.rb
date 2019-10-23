module Cryptoexchange::Exchanges
  module Uniswap
    class Market < Cryptoexchange::Models::Market
      NAME = 'uniswap'
      API_URL = "https://api.blocklytics.org/uniswap/v1"

      def self.api_key
        authentication = Cryptoexchange::Exchanges::Uniswap::Authentication.new(
          :market,
          Cryptoexchange::Exchanges::Uniswap::Market::NAME
        )
        authentication.validate_credentials!
        authentication.api_key
      end
    end
  end
end
