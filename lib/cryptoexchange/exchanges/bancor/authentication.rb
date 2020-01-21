module Cryptoexchange::Exchanges
  module Bancor
    class Authentication < Cryptoexchange::Services::Authentication
      def api_key
        HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
      end

      def headers
        # Do nothing, no headers override needed for API key only
      end

      def required_credentials
        %i(api_key)
      end
    end
  end
end
