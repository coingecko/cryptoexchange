module Cryptoexchange::Exchanges
  module Upbit
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Upbit::Market::API_URL}/days/?code=CRIX.UPBIT.#{market_pair.target}-#{market_pair.base}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Upbit::Market::NAME
          # ticker.ask = NumericHelper.to_d(output['sell'])
          # ticker.bid = NumericHelper.to_d(output['buy'])
          ticker.last = NumericHelper.to_d(output[0]["tradePrice"])
          ticker.high = NumericHelper.to_d(output[0]["highPrice"])
          ticker.low = NumericHelper.to_d(output[0]["lowPrice"])
          ticker.volume = NumericHelper.to_d(output[0]["candleAccTradeVolume"])
          ticker.timestamp = DateTime.parse(output[0]["candleDateTime"]).strftime("%s").to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
