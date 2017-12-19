module Cryptoexchange
  module Services
    class Market
      attr_reader :raw_response
      class << self
        def supports_individual_ticker_query?
          fail "Must define supports_individual_ticker_query? as true or false"
        end
      end

      def fetch(endpoint)
        LruTtlCache.ticker_cache.getset(endpoint) do
          response = http_get(endpoint)
          @raw_response = response
          JSON.parse(response.to_s)
        end
      end

      private

      def http_get(endpoint)
        fetch_response = HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(endpoint)
      end
    end
  end
end
