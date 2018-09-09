module Cryptoexchange::Exchanges
  module Kairex
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
          "#{Cryptoexchange::Exchanges::Kairex::Market::API_URL}/market/ticker?quote=#{market_pair.target}&base=#{market_pair.base}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target

          ticker.base      = base
          ticker.target    = target
          ticker.market    = Kairex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.change    = NumericHelper.to_d(output['changePercent'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
