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
          ticker_output = super(ticker_url(market_pair))
          volume_output = sum_volume(market_pair)
          adapt(ticker_output, volume_output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Upbit::Market::API_URL}/days/?code=CRIX.UPBIT.#{market_pair.target}-#{market_pair.base}"
        end

        def volume_url(market_pair)
          "#{Cryptoexchange::Exchanges::Upbit::Market::API_URL}/minutes/10?code=CRIX.UPBIT.#{market_pair.target}-#{market_pair.base}&count=145"
        end

        def sum_volume(market_pair)
          volume = 0
          raw_output = HTTP.get(volume_url(market_pair))
          output = JSON.parse(raw_output)
            output.each do |ticker|
              volume = volume + ticker["candleAccTradeVolume"]
            end
          {"volume"=>volume}
        end

        def adapt(ticker_output, volume_output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Upbit::Market::NAME
          ticker.last = NumericHelper.to_d(ticker_output[0]["tradePrice"])
          ticker.high = NumericHelper.to_d(ticker_output[0]["highPrice"])
          ticker.low = NumericHelper.to_d(ticker_output[0]["lowPrice"])
          ticker.volume = NumericHelper.to_d(volume_output["volume"])
          ticker.timestamp = Time.now.to_i
          ticker.payload = ticker_output.push(volume_output)
          ticker
        end
      end
    end
  end
end
