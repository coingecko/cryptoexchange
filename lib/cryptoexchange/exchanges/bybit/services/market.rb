module Cryptoexchange::Exchanges
  module Bybit
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output["result"].last, market_pair)
        end

        def ticker_url(market_pair)
          #set interval to 1 days. Will use 87000 seconds ago (86400 seconds / days) to ensure we manage to capture the right interval data
          timestamp = Time.now - 87000
          "#{Cryptoexchange::Exchanges::Bybit::Market::API_URL}/kline/list?interval=D&from=#{timestamp.to_i}&symbol=#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bybit::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.high       = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
