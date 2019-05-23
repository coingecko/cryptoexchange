require 'bigdecimal'

module Cryptoexchange::Exchanges
  module Dcoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Dcoin::Market::API_URL}/allticker"
        end

        def adapt_all(output)
          timestamp = output['date']
          output['ticker'].map do |output|
            adapt(output, timestamp)
          end
        end

        def adapt(output, timestamp)
          base, target     = output['symbol'].split('_')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Dcoin::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
