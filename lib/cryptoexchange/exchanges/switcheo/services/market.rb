module Cryptoexchange::Exchanges
  module Switcheo
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Switcheo::Market::API_URL}/v1/trades/tickers"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['symbol'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Switcheo::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Switcheo::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask_price'])
          ticker.bid       = NumericHelper.to_d(output['bid_price'])
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.high      = NumericHelper.to_d(output['high_price'])
          ticker.low       = NumericHelper.to_d(output['low_price'])
          ticker.volume    = NumericHelper.to_d(output['quote_volume'])
          ticker.timestamp = output['close_time']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
