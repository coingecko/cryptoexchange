module Cryptoexchange
  class Credentials
    class << self
      def get(exchange)
        unless File.exists?(filename)
          raise Cryptoexchange::CredentialsMissingError, "#{filename} does not exist!"
        end

        exchange_credentials = credentials.dig(exchange)
        raise Cryptoexchange::CredentialsMissingError, "Credentials for #{exchange} does not exist!" unless exchange_credentials

        exchange_credentials
      end

      private

      def filename
        'config/cryptoexchange/credentials.yml'
      end

      def credentials
        YAML.load_file(filename)
      end
    end
  end
end
