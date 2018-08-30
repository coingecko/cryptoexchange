module Cryptoexchange::Exchanges
  module Forkdelta
    class Market < Cryptoexchange::Models::Market
      NAME      = 'forkdelta'
      API_URL   = 'https://api.forkdelta.app'
      TOKEN_URL = 'https://forkdelta.app/config/main.json'

      def self.trade_page_url(args={})
        "https://forkdelta.app/#!/trade/#{args[:base]}-#{args[:target]}"
      end

      class << self
        def fetch_symbol
          begin
            fetch_response = http_get(TOKEN_URL)
            if fetch_response.code == 200
              result  = JSON.parse(fetch_response)['tokens']
              symbols = {}
              result.map do |symbol|
                symbols[symbol['addr']] = symbol['name']
              end
              symbols
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

        private

        def http_get(endpoint)
          HTTP.timeout(:write => 2, :connect => 15, :read => 18).follow.get(endpoint)
        end
      end
    end
  end
end
