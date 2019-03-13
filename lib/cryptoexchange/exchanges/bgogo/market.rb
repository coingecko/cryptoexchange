module Cryptoexchange::Exchanges
  module Bgogo
    class Market < Cryptoexchange::Models::Market
      NAME    = 'bgogo'
      API_URL = 'https://bgogo.com/api'

      def self.trade_page_url(args = {})
        "https://bgogo.com/exchange/#{args[:base]}/#{args[:target]}"
      end

      def self.pairs_fetch(endpoint)
        Cryptoexchange::Cache.ticker_cache.fetch(endpoint) do
          begin
            fetch_response =
              HTTP.timeout(:write => 2, :connect => 15, :read => 18).headers(accept: 'application/json').follow.get(endpoint)
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
      end

      def self.ticker_fetch(endpoint)
        Cryptoexchange::Cache.ticker_cache.fetch(endpoint) do
          begin
            response = HTTP.timeout(:write => 2, :connect => 15, :read => 18).headers(accept: 'application/json').follow.get(endpoint)
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
    end
  end
end
