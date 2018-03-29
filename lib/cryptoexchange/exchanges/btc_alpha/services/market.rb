module Cryptoexchange::Exchanges
  module BtcAlpha
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::BtcAlpha::Market::TICKER_URL}/charts/#{base}_#{target}/D/chart?limit=1"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          market = output.first

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BtcAlpha::Market::NAME
          ticker.last      = NumericHelper.to_d(market['close'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = NumericHelper.to_d(market['volume'])
          ticker.timestamp = market['time']
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
