module Cryptoexchange::Exchanges
  module Nexybit
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
          "#{Cryptoexchange::Exchanges::Nexybit::Market::API_URL}/symbols/markets"
        end

        def adapt_all(output)
          output.map do |ticker|
            adapt(ticker)
          end
        end

        def adapt(output)
          base, target     = output['symbol'].split('/')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Nexybit::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.high      = NumericHelper.to_d(output['high_price'])
          ticker.low       = NumericHelper.to_d(output['low_price'])
          ticker.volume    = NumericHelper.to_d(output['h24_trade_amount'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
