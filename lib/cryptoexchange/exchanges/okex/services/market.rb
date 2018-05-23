module Cryptoexchange::Exchanges
  module Okex
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
          "#{Cryptoexchange::Exchanges::Okex::Market::API_URL}/tickers.do"
        end


        def adapt_all(output)
          timestamp = output['date']
          output['tickers'].map do |ticker|
            base, target = ticker['symbol'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Okex::Market::NAME
            )
            adapt(ticker, market_pair, timestamp)
          end
        end

        def adapt(output, market_pair, timestamp)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Okex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = NumericHelper.to_d(timestamp)
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
