module Cryptoexchange::Exchanges
  module BitboxPrivate
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          authentication = Cryptoexchange::Exchanges::BitboxPrivate::Authentication.new(
            :market,
            Cryptoexchange::Exchanges::BitboxPrivate::Market::NAME
          )
          authentication.validate_credentials!

          timestamp = (Time.now.to_i * 1000).to_s
          payload_ = payload(timestamp, market_pair)
          headers = authentication.headers(payload_, timestamp)
          api_url = "#{Cryptoexchange::Exchanges::BitboxPrivate::Market::API_URL}" + endpoint + "?" + params(market_pair)

          output = Cryptoexchange::Cache.ticker_cache.fetch(api_url) do
            HTTP.timeout(15).headers(headers).get(api_url).parse :json
          end

          adapt(output, market_pair)
        end

        def endpoint
          "/v1/market/public/currentTickValue"
        end

        def params(market_pair)
          "coinPair=#{market_pair.base}.#{market_pair.target}"
        end

        def payload(timestamp, market_pair)
          "12345" + timestamp + "GET" + endpoint + params(market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitboxPrivate::Market::API_URL}/currentTickValue?coinPair=#{market_pair.base}.#{market_pair.target}"
        end

        def adapt(output, market_pair)
          output = output["responseData"]
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = BitboxPrivate::Market::NAME
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.bid = NumericHelper.to_d(output['bid'])
          ticker.ask = NumericHelper.to_d(output['ask'])
          ticker.volume = NumericHelper.divide(output['volume'], ticker.last)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
