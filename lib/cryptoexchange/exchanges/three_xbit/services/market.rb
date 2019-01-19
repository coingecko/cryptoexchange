module Cryptoexchange::Exchanges
  module ThreeXbit
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
          "#{Cryptoexchange::Exchanges::ThreeXbit::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |_pair, ticker|
            adapt(ticker)
          end
        end

        def adapt(output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = output['symbol']
          ticker.target    = output['market']
          ticker.market    = ThreeXbit::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['max'])
          ticker.low       = NumericHelper.to_d(output['min'].to_f)
          ticker.bid       = NumericHelper.to_d(output['bid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['ask'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
