module Cryptoexchange::Exchanges
  module BitboxPrivate
    class Authentication < Cryptoexchange::Services::Authentication
      def signature(payload)
        api_secret = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_secret')
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_secret, payload)
      end

      def headers(payload, timestamp)
        api_key = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
        {
          "X-API-Key" => api_key,
          "X-API-SIGN" => signature(payload),
          "X-API-TIMESTAMP" => timestamp,
          "X-API-NONCE" => "12345"
        }
      end

      def required_credentials
        %i(api_key api_secret)
      end
    end
  end
end
