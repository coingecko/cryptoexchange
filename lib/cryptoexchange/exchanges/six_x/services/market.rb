module Cryptoexchange::Exchanges
  module SixX
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::SixX::Market::API_URL}/api/v1/tickers"
        end

        def adapt_all(output)
          timestamp = output['timestamp']
          output['ticker'].map do |pair|
            adapt(pair, timestamp)
          end
        end

        def adapt(output, timestamp)
          base, target     = output['symbol'].split('_')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = SixX::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.timestamp = NumericHelper.to_d(timestamp)
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
