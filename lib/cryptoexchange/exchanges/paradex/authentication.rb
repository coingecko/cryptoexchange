module Cryptoexchange::Exchanges
  module Paradex
    class Authentication < Cryptoexchange::Services::Authentication
      def signature
        api_key = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
      end

      def headers
        { "API-KEY": signature }
      end

      def required_credentials
        %i(api_key)
      end
    end
  end
end
