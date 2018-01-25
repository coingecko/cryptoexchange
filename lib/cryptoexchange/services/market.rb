module Cryptoexchange
  module Services
    class Market
      class << self
        def supports_individual_ticker_query?
          fail "Must define supports_individual_ticker_query? as true or false"
        end
      end

      def fetch(endpoint)
        LruTtlCache.ticker_cache.getset(endpoint) do
          response = http_get(endpoint)
          JSON.parse(response.to_s)
        end
      end

      def fetch_using_post(endpoint, params)
        LruTtlCache.ticker_cache.getset(endpoint) do
          response = http_post(endpoint, params)
          JSON.parse(response.to_s)
        end
      end

      private

      def http_get(endpoint)
        fetch_response = HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(endpoint)
      end

      def http_post(endpoint, params)
        HTTP.timeout(:write => 2, :connect => 5, :read => 8).post(endpoint, :json => params)
      end
    end
  end
end
