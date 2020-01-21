module Cryptoexchange::Exchanges
  module Bancor
    class Market < Cryptoexchange::Models::Market
      NAME = 'bancor'
      API_URL = 'http://api.blocklytics.org/pools/v0'

      def self.api_key
        authentication = Cryptoexchange::Exchanges::Bancor::Authentication.new(
          :market,
          Cryptoexchange::Exchanges::Bancor::Market::NAME
        )
        authentication.validate_credentials!
        authentication.api_key
      end
    end
  end
end
