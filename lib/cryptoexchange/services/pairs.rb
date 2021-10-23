require 'yaml'

module Cryptoexchange
  module Services
    class Pairs
      PAIRS_URL   = nil
      HTTP_METHOD = 'GET'
      POST_PARAMS = nil
      MARKET      = nil

      def fetch
        # If PAIRS_URL provided, use that to fetch market pairs
        return fetch_via_api if self.class::PAIRS_URL

        # If gem user has an overriden yaml, use that
        return fetch_via_override(user_override_path) if user_override_exist?

        # Falls back to default overriden yaml
        return fetch_via_override(default_override_path) if default_override_exist?
      end

      def fetch_via_api(endpoint = self.class::PAIRS_URL, params = self.class::POST_PARAMS)
        Cryptoexchange::Cache.ticker_cache.fetch(endpoint) do
          begin
            fetch_response = self.class::HTTP_METHOD == 'POST' ? http_post(endpoint, params) : http_get(endpoint)
            if fetch_response.code == 200
              JSON.parse fetch_response, allow_nan: true
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
      end

      def fetch_via_api_using_post(endpoint = self.class::PAIRS_URL, headers = false, body = false)
        fetch_response = if headers && body
                           WrappedHTTP.client.timeout(10).headers(headers).post(endpoint, body: body)
                         else
                           WrappedHTTP.client.timeout(10).post(endpoint)
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

      def http_get(endpoint)
        WrappedHTTP.client.timeout(25).follow.use(:auto_inflate).get(endpoint)
      end

      def http_post(endpoint, params)
        WrappedHTTP.client.timeout(15).post(endpoint, json: params)
      end
    end
  end
end
