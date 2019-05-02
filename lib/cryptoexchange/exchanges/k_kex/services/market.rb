module Cryptoexchange::Exchanges
  module KKex
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
          "#{Cryptoexchange::Exchanges::KKex::Market::API_URL}/ticker?symbol=#{market_pair.base}#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target

          ticker.base      = base
          ticker.target    = target
          ticker.market    = KKex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ticker']['sell'])
          ticker.bid       = NumericHelper.to_d(output['ticker']['buy'])
          ticker.last      = NumericHelper.to_d(output['ticker']['last'])
          ticker.low       = NumericHelper.to_d(output['ticker']['low'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'])
          ticker.high      = NumericHelper.to_d(output['ticker']['high'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
