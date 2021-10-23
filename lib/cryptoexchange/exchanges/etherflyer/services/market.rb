module Cryptoexchange::Exchanges
  module Etherflyer
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
          "#{Cryptoexchange::Exchanges::Etherflyer::Market::API_URL}/market/allticker"
        end

        def adapt_all(output)
          timestamp = output['date']
          output['ticker'].map do |ticker|
            next unless ticker['symbol']
            adapt(ticker, timestamp)
          end.compact
        end

        def adapt(output, timestamp)
          base, target     = output['symbol'].split("_")
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Etherflyer::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
