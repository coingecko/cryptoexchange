module Cryptoexchange::Exchanges
  module RadarRelay
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ticker_output = super(ticker_url(market_pair))
          candle_output = super(candle_url(market_pair))
          adapt(market_pair, ticker_output, candle_output.first)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::RadarRelay::Market::API_URL}/markets/#{market_pair.base}-#{market_pair.target}/ticker"
        end

        def candle_url(market_pair)
          "#{Cryptoexchange::Exchanges::RadarRelay::Market::API_URL}/markets/#{market_pair.base}-#{market_pair.target}/candles"
        end

        def adapt(market_pair, ticker_output, candle_output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = RadarRelay::Market::NAME
          ticker.bid       = NumericHelper.to_d(ticker_output['bestBid'])
          ticker.ask       = NumericHelper.to_d(ticker_output['bestAsk'])
          ticker.last      = NumericHelper.to_d(candle_output['close'])
          ticker.high      = NumericHelper.to_d(candle_output['high'])
          ticker.low       = NumericHelper.to_d(candle_output['low'])
          ticker.volume    = NumericHelper.to_d(candle_output['baseTokenVolume'])
          ticker.timestamp = NumericHelper.to_d(ticker_output['timestamp'])
          ticker.payload   = [ticker_output, candle_output]
          ticker
        end
      end
    end
  end
end
