module Cryptoexchange
  module Services
    class Market
      def fetch(endpoint)
        fail "This exchange does not support individual ticker query!" unless self.class.supports_individual_ticker_query?
        http_get(endpoint)
      end

      def fetch_all
        fail "This exchange does not support batch tickers query!" if self.class.supports_individual_ticker_query?
        fetch_response = http_get(tickers_url)
        adapt_all(fetch_response)
      end

      def tickers_url
        nil
      end

      def ticker_url(market_pair)
        nil
      end

      private

      def http_get(endpoint)
        fetch_response = HTTP.get(endpoint)
        response = JSON.parse(fetch_response.to_s)
      end
    end
  end
end
