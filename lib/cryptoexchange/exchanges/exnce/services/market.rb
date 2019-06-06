module Cryptoexchange::Exchanges
  module Exnce
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
          "#{Cryptoexchange::Exchanges::Exnce::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          timestamp = output['date']
          output['data'].map do |ticker|
            next unless ticker['pair']
            adapt(ticker, timestamp)
          end.compact
        end

        def adapt(output, timestamp)
          base, target     = output['pair'].split("/")
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Exnce::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = NumericHelper.to_d(output['timestamp'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
