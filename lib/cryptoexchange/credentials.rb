module Cryptoexchange
  class Credentials
    class << self
      def get(exchange)
        unless File.exists?(filename)
          raise Cryptoexchange::CredentialsMissingError, "#{filename} does not exist!"
        end

        # Instead of dig for earlier version of Ruby support
        exchange_credentials = credentials ? credentials[exchange] : nil
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
