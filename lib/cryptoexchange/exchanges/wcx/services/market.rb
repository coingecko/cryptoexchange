module Cryptoexchange::Exchanges
  module Wcx
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ticker_output = super(ticker_url(market_pair))
          candle_output = super(candles_url(market_pair))
          adapt(ticker_output, candle_output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Wcx::Market::API_URL}/ticker/#{base}-#{target}"
        end

        def candles_url(market_pair)
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Wcx::Market::API_URL}/candles/#{base}-#{target}/240"
        end

        # ticker output
        # {
        #   "timestamp": "1527148649751.886",
        #   "product": "ETH-BTC",
        #   "price": "0.078238",
        #   "bid": "0.07815",
        #   "ask": "0.07829",
        #   "bid_size": "8.46600000",
        #   "ask_size": "9.00000000"
        # }
        # candle output
        # [
        #   1511251200,   timestamp
        #   0.044683,     open
        #   0.053744,     high
        #   0.042048,     low
        #   0.045321,     close
        #   "3310.527428" volume
        # ]

        def adapt(ticker_output, candle_output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          candle_data = candle_output.first
          volume = 0
          candle_data[0..5].map do |vol|
            volume += vol[-1].to_f
          end


          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Wcx::Market::NAME
          ticker.ask       = NumericHelper.to_d(ticker_output['ask'])
          ticker.bid       = NumericHelper.to_d(ticker_output['bid'])
          ticker.last      = NumericHelper.to_d(ticker_output['price'])
          ticker.high      = NumericHelper.to_d(candle_data[2])
          ticker.low       = NumericHelper.to_d(candle_data[3])
          ticker.volume    = NumericHelper.to_d(volume)
          ticker.timestamp = ticker_output['timestamp'].to_i / 1000
          ticker.payload   = [ticker_output, candle_output]
          ticker
        end
      end
    end
  end
end
