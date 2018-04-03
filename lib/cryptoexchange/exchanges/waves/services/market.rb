module Cryptoexchange::Exchanges
  module Waves
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Waves::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['symbol'].split("/")
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Waves::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Waves::Market::NAME
          ticker.last      = NumericHelper.to_d(output['24h_close'])
          ticker.high      = NumericHelper.to_d(output['24h_high'])
          ticker.low       = NumericHelper.to_d(output['24h_low'])
          ticker.volume    = NumericHelper.to_d(output['24h_volume'])
          ticker.timestamp = output['timestamp'] / 1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
