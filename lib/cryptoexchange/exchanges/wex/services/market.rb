module Cryptoexchange::Exchanges
  module Wex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Wex::Market::API_URL}/ticker/#{symbol(market_pair)}"
        end

        def symbol(market_pair)
          "#{market_pair.base.downcase}_#{market_pair.target.downcase}"
        end

        def adapt(market_pair, output)
          output = output[symbol(market_pair)]

          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Wex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['vol_cur'])
          ticker.timestamp = output['updated'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
