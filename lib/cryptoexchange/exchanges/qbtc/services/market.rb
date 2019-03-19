module Cryptoexchange::Exchanges
  module Qbtc
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = Cryptoexchange::Cache.ticker_cache.fetch(ticker_url) do
            HTTP.post(ticker_url).parse(:json)
          end

          adapt_all(output['result'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Qbtc::Market::API_URL}/getAllCoinInfo.do"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['symbol'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Qbtc::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Qbtc::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sellone'])
          ticker.bid       = NumericHelper.to_d(output['buyone'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
