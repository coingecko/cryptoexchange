module CryptoexchangeRuby
  module Services
    class Pairs
      def fetch(endpoint)
        fetch_response = HTTP.get(endpoint)
        response = JSON.parse(fetch_response.to_s)
      end
    end
  end
end
