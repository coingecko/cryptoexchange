module Cryptoexchange::Exchanges
  module UpbitIndonesia
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
          "#{Cryptoexchange::Exchanges::UpbitIndonesia::Market::API_URL}/candles/minutes/5?code=CRIX.UPBIT.#{market_pair.target.upcase}-#{market_pair.base.upcase}&count=288"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = UpbitIndonesia::Market::NAME
          ticker.last = NumericHelper.to_d(output[0]['tradePrice'])
          ticker.high = NumericHelper.to_d(output[0]['highPrice'])
          ticker.low = NumericHelper.to_d(output[0]['lowPrice'])
          ticker.volume = adapt_volume(output)
          ticker.timestamp = nil
          ticker.payload = output[0]
          ticker
        end

        def adapt_volume(output)
          sum = 0
          output.each do |output|
            sum += output["candleAccTradeVolume"]
          end
          sum
        end
      end
    end
  end
end
