module Cryptoexchange
  module Services
    module Options
      class Ticker
        def fetch(endpoint)
          Cryptoexchange::Cache.ticker_cache.fetch(endpoint) do
            begin
              response = http_get(endpoint)
              if response.code == 200
                JSON.parse response, allow_nan: true
              elsif response.code == 400
                raise Cryptoexchange::HttpBadRequestError, { response: response }
              else
                raise Cryptoexchange::HttpResponseError, { response: response }
              end
            rescue HTTP::ConnectionError => e
              raise Cryptoexchange::HttpConnectionError, { error: e, response: response }
            rescue HTTP::TimeoutError => e
              raise Cryptoexchange::HttpTimeoutError, { error: e, response: response }
            rescue JSON::ParserError => e
              raise Cryptoexchange::JsonParseError, { error: e, response: response }
            rescue TypeError => e
              raise Cryptoexchange::TypeFormatError, { error: e, response: response }
            end
          end
        end

        private

        def http_get(endpoint)
          WrappedHTTP.client.timeout(25).follow.use(:auto_inflate).get(endpoint)
        end
      end
    end
  end
end
