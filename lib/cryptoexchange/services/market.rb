module Cryptoexchange
  module Services
    class Market
      def fetch(endpoint)
        fetch_response = http_get(endpoint)
        response = JSON.parse(fetch_response.to_s)
      end

      def http_get(endpoint)
        puts 'fetcher!'
        HTTP.get(endpoint)
      end

    end
  end
end
