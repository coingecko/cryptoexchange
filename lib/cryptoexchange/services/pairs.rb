require 'yaml'

module Cryptoexchange
  module Services
    class Pairs
      PAIRS_URL    = nil
      AUTO_INFLATE = false
      HTTP_METHOD  = 'GET'
      POST_PARAMS  = nil
      MARKET       = nil

      def fetch
        # If PAIRS_URL provided, use that to fetch market pairs
        return fetch_via_api if self.class::PAIRS_URL

        # If gem user has an overriden yaml, use that
        return fetch_via_override(user_override_path) if user_override_exist?

        # Falls back to default overriden yaml
        return fetch_via_override(default_override_path) if default_override_exist?
      end

      def fetch_via_api(endpoint = self.class::PAIRS_URL, params = self.class::POST_PARAMS)
        begin
          fetch_response = api_response(endpoint, params)
          if fetch_response.code == 200
            fetch_response.parse :json
          elsif fetch_response.code == 400
            raise Cryptoexchange::HttpBadRequestError, { response: fetch_response }
          else
            raise Cryptoexchange::HttpResponseError, { response: fetch_response }
          end
        rescue HTTP::ConnectionError => e
          raise Cryptoexchange::HttpConnectionError, { error: e, response: fetch_response }
        rescue HTTP::TimeoutError => e
          raise Cryptoexchange::HttpTimeoutError, { error: e, response: fetch_response }
        rescue JSON::ParserError => e
          raise Cryptoexchange::JsonParseError, { error: e, response: fetch_response }
        rescue TypeError => e
          raise Cryptoexchange::TypeFormatError, { error: e, response: fetch_response }
        end
      end

      def fetch_via_api_using_post(endpoint = self.class::PAIRS_URL, headers = false, body = false)
        fetch_response = if headers && body
                           HTTP.timeout(:write => 2, :connect => 5, :read => 8).headers(headers).post(endpoint, body: body)
                         else
                           HTTP.timeout(:write => 2, :connect => 5, :read => 8).post(endpoint)
                         end
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

      def api_response(endpoint, params)
        if self.class::HTTP_METHOD == 'POST'
          http_post(endpoint, params)
        elsif self.class::AUTO_INFLATE
          http_get_gzip_response(endpoint)
        else
          http_get(endpoint)
        end
      end

      def http_get(endpoint)
        HTTP.timeout(:write => 2, :connect => 15, :read => 18).follow.get(endpoint)
      end

      def http_post(endpoint, params)
        HTTP.timeout(:write => 2, :connect => 5, :read => 8).post(endpoint, json: params)
      end

      def http_get_gzip_response(endpoint)
        HTTP
          .timeout(:write => 2, :connect => 15, :read => 18)
          .use(:auto_inflate)
          .headers('Accept-Encoding' => 'gzip').get(endpoint)
      end
    end
  end
end
