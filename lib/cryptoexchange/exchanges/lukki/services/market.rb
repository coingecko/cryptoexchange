module Cryptoexchange::Exchanges
  module Lukki
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
          "#{Cryptoexchange::Exchanges::Lukki::Market::API_URL}/trading/tickers"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['ticker'].split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new({
                            base: base,
                            target: target,
                            market: Lukki::Market::NAME
                          })
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Lukki::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.high      = NumericHelper.to_d(output['high24h'])
          ticker.low       = NumericHelper.to_d(output['low24h'])
          ticker.last      = NumericHelper.to_d(output['lastDone'])
          ticker.volume    = NumericHelper.to_d(output['base24hVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
