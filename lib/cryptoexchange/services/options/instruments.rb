module Cryptoexchange
  module Services
    module Options
      class Instruments
        PAIRS_URL   = nil
        HTTP_METHOD = 'GET'
        MARKET      = nil

        def fetch
          # If PAIRS_URL provided, use that to fetch market pairs
          return fetch_via_api if self.class::PAIRS_URL
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

        def exchange_class
          exchange_name = self.class.name.split('::')[2]
          Object.const_get "Cryptoexchange::Exchanges::#{exchange_name}::Market"
        end

        def http_get(endpoint)
          WrappedHTTP.client.timeout(25).follow.use(:auto_inflate).get(endpoint)
        end
      end
    end
  end
end
