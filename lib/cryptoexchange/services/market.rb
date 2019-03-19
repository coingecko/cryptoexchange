module Cryptoexchange
  module Services
    class Market
      class << self
        def supports_individual_ticker_query?
          fail "Must define supports_individual_ticker_query? as true or false"
        end
      end

      def fetch(endpoint)
        Cryptoexchange::Cache.ticker_cache.fetch(endpoint) do
          begin
            response = http_get(endpoint)
            if response.code == 200
              response.parse :json
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

      def fetch_using_post(endpoint, params, headers = false)
        Cryptoexchange::Cache.ticker_cache.fetch([endpoint, params]) do
          response = if headers
                       http_post_with_headers(endpoint, params, headers)
                     else
                       http_post(endpoint, params)
                     end

          JSON.parse(response.to_s)
        end
      end

      private

      def http_get(endpoint)
        HTTP.timeout(:write => 2, :connect => 15, :read => 18).follow.get(endpoint)
      end

      def http_post(endpoint, params)
        HTTP.timeout(:write => 2, :connect => 5, :read => 8).post(endpoint, :json => params)
      end

      def http_post_with_headers(endpoint, params, headers)
        HTTP.timeout(:write => 2, :connect => 5, :read => 8).headers(headers).post(endpoint, :body => params)
      end

    end
  end
end
