module Cryptoexchange::Exchanges
  module Paradex
    class Authentication < Cryptoexchange::Services::Authentication
      def headers(payload)
        api_key = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
        { 'API-KEY' => api_key }
      end

      def required_credentials
        %i(api_key)
      end
    end
  end
end
