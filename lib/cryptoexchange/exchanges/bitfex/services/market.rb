module Cryptoexchange::Exchanges
  module Bitfex
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
          trading_pair_id = "#{market_pair.base}_#{market_pair.target}"
          "#{Cryptoexchange::Exchanges::Bitfex::Market::API_URL}/api/v1/ticker/#{trading_pair_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitfex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.ask       = NumericHelper.to_d(output['buy'])
          ticker.bid       = NumericHelper.to_d(output['sell'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
