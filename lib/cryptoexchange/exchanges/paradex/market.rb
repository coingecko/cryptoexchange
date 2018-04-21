module Cryptoexchange::Exchanges
  module Paradex
    class Market
      NAME    = 'paradex'
      API_URL = 'https://api.paradex.io/consumer'

      class << self
        def fetch_via_api(endpoint)
          api_key = fetch_api_key(user_api_key_path)

          begin
            fetch_response = HTTP.timeout(write: 2, connect: 15, read: 18).headers("API-KEY": "#{api_key}")
                               .get(endpoint)
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

        def fetch_api_key(path)
          raise Cryptoexchange::ApiKeyMissingError, { error: "Please set api_key in 'config/cryptoexchange/paradex.yml'"} unless user_api_key_exist?

          YAML.load_file(path)[:api_key]
        end

        def user_api_key_path
          "config/cryptoexchange/paradex.yml"
        end

        def user_api_key_exist?
          File.exist? user_api_key_path
        end
      end
    end
  end
end
