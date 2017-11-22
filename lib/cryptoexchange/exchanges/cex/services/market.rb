module Cryptoexchange::Exchanges
  module Cex
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
          "#{Cryptoexchange::Exchanges::Cex::Market::API_URL}/ticker/#{market_pair.base}/#{market_pair.target}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          base = market_pair.base
          target = market_pair.target
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Cex::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = output['timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
