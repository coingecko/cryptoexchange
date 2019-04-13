module Cryptoexchange::Exchanges
  module Bitbegin
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
          "#{Cryptoexchange::Exchanges::Bitbegin::Market::API_URL}/getmarketsummaries"
        end

        def adapt_all(output)
          output['result'].map do |ticker|
            adapt(ticker)
          end
        end

        def adapt(output)
          base, target     = output['MarketName'].split('_')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Bitbegin::Market::NAME
          ticker.high      = NumericHelper.to_d(output['High'])
          ticker.low       = NumericHelper.to_d(output['Low'])
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.volume    = NumericHelper.to_d(output['Volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
