module Cryptoexchange::Exchanges
  module Bitsdaq
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
          "#{Cryptoexchange::Exchanges::Bitsdaq::Market::API_URL}/normal/dg/marketSummary24h/detail"
        end

        def adapt_all(output)
          output.map do |data|
            adapt(data)
          end
        end

        def adapt(data)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = data['symbol']
          ticker.target    = data['anchor']
          ticker.market    = Bitsdaq::Market::NAME
          ticker.last      = NumericHelper.to_d(data['last_price'])
          ticker.volume    = NumericHelper.to_d(data['volume_24h'])
          ticker.timestamp = nil
          ticker.payload   = data
          ticker
        end
      end
    end
  end
end
