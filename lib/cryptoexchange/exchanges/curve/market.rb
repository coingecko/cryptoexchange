module Cryptoexchange::Exchanges
  module Curve
    class Market < Cryptoexchange::Models::Market
      NAME = 'curve'

      def self.api_key
        authentication = Cryptoexchange::Exchanges::Curve::Authentication.new(
          :market,
          Cryptoexchange::Exchanges::Curve::Market::NAME
        )
        authentication.validate_credentials!
        authentication.api_key
      end
    end
  end
end
