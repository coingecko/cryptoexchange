require 'yaml'

module Cryptoexchange
  module Services
    class Pairs
      PAIRS_URL = nil
      MARKET = nil

      def fetch
        # If PAIRS_URL provided, use that to fetch market pairs
        return fetch_via_api if self.class::PAIRS_URL

        # If gem user has an overriden yaml, use that
        return fetch_via_override(user_override_path) if user_override_exist?

        # Falls back to default overriden yaml
        return fetch_via_override(default_override_path) if default_override_exist?
      end

      def fetch_via_api(endpoint = self.class::PAIRS_URL)
        fetch_response = HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(endpoint)
        JSON.parse(fetch_response.to_s)
      end

      def fetch_via_override(path)
        YAML.load_file(path)[:pairs]
      end

      def user_override_path
        "config/cryptoexchange/#{exchange_class::NAME}.yml"
      end

      def default_override_path
        File.join(File.dirname(__dir__), "exchanges/#{exchange_class::NAME}/#{exchange_class::NAME}.yml")
      end

      def user_override_exist?
        File.exist? user_override_path
      end

      def default_override_exist?
        File.exist? default_override_path
      end

      def exchange_class
        exchange_name = self.class.name.split('::')[2]
        Object.const_get "Cryptoexchange::Exchanges::#{exchange_name}::Market"
      end
    end
  end
end
