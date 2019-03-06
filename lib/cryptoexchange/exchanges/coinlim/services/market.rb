module Cryptoexchange::Exchanges
  module Coinlim
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = Cryptoexchange::Cache.ticker_cache.fetch(ticker_url) do
            HTTP.get(ticker_url).parse(:json)
          end

          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinlim::Market::API_URL}/server/tickers"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            adapt(pair)
          end
        end

        def adapt(output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = output['tradeCurrency']
          ticker.target    = output['currency']
          ticker.market    = Coinlim::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'].to_f)
          ticker.low       = NumericHelper.to_d(output['low'].to_f)
          ticker.bid       = NumericHelper.to_d(output['bid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['ask'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
