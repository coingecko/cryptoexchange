require 'yaml'

module Cryptoexchange
  module Services
    class Account

      def fetch(endpoint, header, params)
        response = http_post(endpoint, header, params)
        JSON.parse(response.to_s)
      end

      def config_setup
        if user_settings_exist?
          fetch_setup_file(user_settings_path)
        else
          fetch_setup_file(default_settings_path)
        end
      end

      private

      def http_post(endpoint, header, params)
        HTTP.timeout(:write => 2, :connect => 5, :read => 8)
            .headers(header)
            .post(endpoint, :form => params)
      end

      def fetch_setup_file(path)
        YAML.load_file(path)[:api]
      end

      def user_settings_path
        "config/cryptoexchange/#{exchange_class::NAME}_settings.yml"
      end

      def default_settings_path
        File.join(File.dirname(__dir__), "exchanges/#{exchange_class::NAME}/#{exchange_class::NAME}_settings.yml")
      end

      def user_settings_exist?
        File.exist? user_settings_path
      end

      def exchange_class
        exchange_name = self.class.name.split('::')[2]
        Object.const_get "Cryptoexchange::Exchanges::#{exchange_name}::Market"
      end
    end
  end
end
