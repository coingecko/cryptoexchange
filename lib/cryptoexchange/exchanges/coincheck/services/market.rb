module Cryptoexchange::Exchanges
  module Coincheck
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(_)
          output = super(ticker_url(_))
          adapt(output)
        end

        def ticker_url(_)
          "#{Cryptoexchange::Exchanges::Coincheck::Market::API_URL}/ticker"
        end

        def adapt(output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = 'BTC'
          ticker.target    = 'JPY'
          ticker.market    = Coincheck::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = output['timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
