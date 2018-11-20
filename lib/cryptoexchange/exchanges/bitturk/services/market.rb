module Cryptoexchange::Exchanges
  module Bitturk
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
          "#{Cryptoexchange::Exchanges::Bitturk::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            adapt(ticker)
          end
        end

        def adapt(output)
          base, target     = output['pair'].split(/(TRY$)+/)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Bitturk::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = NumericHelper.to_d(output['timestamp'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
