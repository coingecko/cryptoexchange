module Cryptoexchange::Exchanges
  module Graviex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = fetch_inner(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          market = "#{market_pair.base}#{market_pair.target}".downcase!
          "#{Cryptoexchange::Exchanges::Graviex::Market::API_URL}/tickers/#{market}.json"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker_json      = output['ticker']
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Graviex::Market::NAME
          ticker.bid       = NumericHelper.to_d(ticker_json['buy'])
          ticker.ask       = NumericHelper.to_d(ticker_json['sell'])
          ticker.low       = NumericHelper.to_d(ticker_json['low'])
          ticker.high      = NumericHelper.to_d(ticker_json['high'])
          ticker.last      = NumericHelper.to_d(ticker_json['last'])
          ticker.volume    = NumericHelper.to_d(ticker_json['vol'])
          ticker.timestamp = ticker_json['at'].to_i
          ticker.payload   = output
          ticker
        end

        private

      def fetch_inner(endpoint)
        LruTtlCache.ticker_cache.getset(endpoint) do
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

      def fetch_using_post(endpoint, params, submit_as_form = false)
        LruTtlCache.ticker_cache.getset(endpoint) do
          response = http_post(endpoint, params)
          JSON.parse(response.to_s)
        end
      end

      def http_get(endpoint)
        ssl_context = OpenSSL::SSL::SSLContext.new
        ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
        fetch_response = HTTP.timeout(:write => 2, :connect => 15, :read => 18)
                             .follow.get(endpoint, ssl_context: ssl_context)
      end

      def http_post(endpoint, params)
        HTTP.timeout(:write => 2, :connect => 5, :read => 8).post(endpoint, :json => params)
      end

     end
    end
  end
end
