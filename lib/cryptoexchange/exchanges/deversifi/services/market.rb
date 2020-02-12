module Cryptoexchange::Exchanges
  module Deversifi
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output[0], market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.upcase
          target = market_pair.target.upcase
          "#{Cryptoexchange::Exchanges::Deversifi::Market::API_URL}/bfx/v2/tickers?symbols=t#{base}#{target}"
        end

        def adapt(output, market_pair)
          # [
          #   0 SYMBOL,
          #   1 BID,
          #   2 ID_SIZE,
          #   3 ASK,
          #   4 ASK_SIZE,
          #   5 DAILY_CHANGE,
          #   6 DAILY_CHANGE_PERC,
          #   7 LAST_PRICE,
          #   8 VOLUME,
          #   9 HIGH,
          #   10 LOW
          # ]

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Deversifi::Market::NAME
          ticker.last      = NumericHelper.to_d(output[7])
          ticker.bid       = NumericHelper.to_d(output[1])
          ticker.ask       = NumericHelper.to_d(output[3])
          ticker.high      = NumericHelper.to_d(output[9])
          ticker.low       = NumericHelper.to_d(output[10])
          ticker.volume    = NumericHelper.to_d(output[8])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
