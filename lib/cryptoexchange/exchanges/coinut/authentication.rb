module Cryptoexchange::Exchanges
  module Coinut
    class Authentication < Cryptoexchange::Services::Authentication
      def signature(payload)
        # Instead of dig for earlier version of Ruby support
        exchange = Cryptoexchange::Credentials.get(@exchange)
        api_key = exchange ? exchange['api_key'] : nil
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_key, payload)
      end

      def headers(payload)
        # Instead of dig for earlier version of Ruby support
        exchange = Cryptoexchange::Credentials.get(@exchange)
        username = exchange ? exchange['username'] : nil
        { 'X-USER' => username, 'X-SIGNATURE' => signature(payload) }
      end

      def required_credentials
        %i(api_key username)
      end
    end
  end
end
