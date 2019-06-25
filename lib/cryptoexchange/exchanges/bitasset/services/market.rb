module Cryptoexchange::Exchanges
  module Bitasset
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
          "#{Cryptoexchange::Exchanges::Bitasset::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output["ticker"].map do |pair|
            base, target = pair["symbol"].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base.upcase,
              target: target.upcase,
              market: Bitasset::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitasset::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
