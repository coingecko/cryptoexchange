module Cryptoexchange::Exchanges
  module Coinut
    class Authentication < Cryptoexchange::Services::Authentication
      def signature(payload)
        api_key = Cryptoexchange::Credentials.get(@exchange).dig('api_key')
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_key, payload)
      end

      def headers(payload)
        username = Cryptoexchange::Credentials.get(@exchange).dig('username')
        { 'X-USER' => username, 'X-SIGNATURE' => signature(payload) }
      end

      def required_credentials
        %i(api_key username)
      end
    end
  end
end
