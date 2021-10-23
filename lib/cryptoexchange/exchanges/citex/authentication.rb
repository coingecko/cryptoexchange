module Cryptoexchange::Exchanges
  module Citex
    class Authentication < Cryptoexchange::Services::Authentication
      def headers
         api_key = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
        {
          "Authorization" => api_key
        }
      end

      def required_credentials
        %i(api_key)
      end
    end
  end
end
