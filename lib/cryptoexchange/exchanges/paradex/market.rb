module Cryptoexchange::Exchanges
  module Paradex
    class Market
      NAME    = 'paradex'
      API_URL = 'https://api.paradex.io/consumer'

      class << self
        def trade_page_url(args={})
          base = args[:base].downcase
          target =args[:target].downcase
          "https://paradex.io/market/#{base}-#{target}"
        end

        def fetch_via_api(endpoint, headers)
          begin
            fetch_response = HTTP.timeout(write: 2, connect: 15, read: 18).headers(headers)
                               .get(endpoint)
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
    end
  end
end
