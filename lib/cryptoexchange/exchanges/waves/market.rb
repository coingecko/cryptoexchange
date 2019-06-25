module Cryptoexchange::Exchanges
  module Waves
    class Market < Cryptoexchange::Models::Market
      NAME    = 'waves'
      API_URL = 'https://api.wavesplatform.com/v0'
      TOKEN_URL = 'https://api.wavesplatform.com/v0/assets?ticker=*'


      class << self
        def fetch_symbol
          Cryptoexchange::Cache.ticker_cache.fetch(TOKEN_URL) do
            begin
              fetch_response = http_get(TOKEN_URL)
              if fetch_response.code == 200
                result  = JSON.parse(fetch_response)["data"]
                symbols = {}
                result.map do |symbol|
                  symbol = symbol["data"]
                  symbols[symbol['id']] = symbol['ticker']
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
        end

        private

        def http_get(endpoint)
          HTTP.timeout(15).follow.get(endpoint)
        end
      end
    end
  end
end
