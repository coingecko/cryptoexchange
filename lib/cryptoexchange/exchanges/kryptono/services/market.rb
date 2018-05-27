module Cryptoexchange::Exchanges
  module Kryptono
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ticker_output = super(ticker_url(market_pair, "1m"))
          volume_output = super(ticker_url(market_pair, "4h"))
          adapt(ticker_output, volume_output, market_pair)
        end

        def ticker_url(market_pair, tt)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Kryptono::Market::API_URL}/cs?symbol=#{base}_#{target}&tt=#{tt}"
        end


        # [
        #   1527379200000, timestamp
        #   "0.07971168",  open
        #   "0.07971168",  high
        #   "0.07971168",  low
        #   "0.07971168",  close
        #   "0.00000000"   volume
        # ]

        def adapt(ticker_output, volume_output, market_pair)
          ticker_value     = ticker_output['series'].last
          volume           = 0
          volume_output['series'].last(6).map do |vol|
            volume += vol[-1].to_f
          end
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Kryptono::Market::NAME
          ticker.last      = NumericHelper.to_d(ticker_value[4])
          ticker.high      = NumericHelper.to_d(ticker_value[2])
          ticker.low       = NumericHelper.to_d(ticker_value[3])
          ticker.volume    = NumericHelper.to_d(volume)
          ticker.timestamp = ticker_value[0] / 1000
          ticker.payload   = [ticker_output, volume_output]
          ticker
        end
      end
    end
  end
end
