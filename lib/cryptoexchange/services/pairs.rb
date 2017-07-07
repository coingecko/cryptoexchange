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

      def fetch_via_api
        fetch_response = HTTP.get(self.class::PAIRS_URL)
        JSON.parse(fetch_response.to_s)
      end

      def fetch_via_override(path)
        YAML.load_file(path)[:pairs]
      end

      def user_override_path
        "config/cryptoexchange/#{self.class::MARKET::NAME}.yml"
      end

      def default_override_path
        File.join(File.dirname(__dir__), "exchanges/#{self.class::MARKET::NAME}/#{self.class::MARKET::NAME}.yml")
      end

      def user_override_exist?
        File.exist? user_override_path
      end

      def default_override_exist?
        File.exist? default_override_path
      end
    end
  end
end
