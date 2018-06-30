module Cryptoexchange::Exchanges
  module Coinut
    class Authentication < Cryptoexchange::Services::Authentication
      def signature(payload: payload)
        api_key = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_key, payload)
      end

      def headers(payload: payload)
        username = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'username')
        { 'X-USER' => username, 'X-SIGNATURE' => signature(payload) }
      end

      def required_credentials
        %i(api_key username)
      end
    end
  end
end
