module Cryptoexchange::Exchanges
  module Piexgo
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
          market_pair = "#{market_pair.base.upcase}_#{market_pair.target.upcase}"
          "#{Cryptoexchange::Exchanges::Piexgo::Market::API_URL}/api/v1/ticker?symbol=#{market_pair}"
        end

        def adapt(output, market_pair)
          market = output['ticker']

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Piexgo::Market::NAME
          ticker.last      = NumericHelper.to_d(market['last_price'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.change    = NumericHelper.to_d(market['change'])
          ticker.volume    = NumericHelper.to_d(market['volume'])
          ticker.timestamp = nil
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
