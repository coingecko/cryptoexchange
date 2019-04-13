module Cryptoexchange::Exchanges
  module Gdac
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE

          output = Cryptoexchange::Cache.ticker_cache.fetch(ticker_url) do
            HTTP.get(ticker_url, ssl_context: ctx).parse(:json)
          end

          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Gdac::Market::API_URL}/public/marketsummaries"
        end

        def adapt_all(output)
          output['result'].map { |market_data| adapt(market_data) }
        end

        def adapt(market_data)
          target, base = market_data['marketName'].split('-')
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = base
          ticker.target = target
          ticker.market = Gdac::Market::NAME
          ticker.ask = NumericHelper.to_d(market_data['ask'])
          ticker.bid = NumericHelper.to_d(market_data['bid'])
          ticker.last = NumericHelper.to_d(market_data['last'])
          ticker.high = NumericHelper.to_d(market_data['high'])
          ticker.low = NumericHelper.to_d(market_data['low'])
          ticker.volume = NumericHelper.to_d(market_data['volume'])
          ticker.timestamp = nil
          ticker.payload = market_data
          ticker
        end
      end
    end
  end
end
