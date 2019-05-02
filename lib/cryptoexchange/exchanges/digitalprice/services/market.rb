module Cryptoexchange::Exchanges
  module Digitalprice
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
          "#{Cryptoexchange::Exchanges::Digitalprice::Market::API_URL}/markets"
        end

        def adapt_all(output)
          output['data'].map do |output|
            adapt(output)
          end
        end

        def adapt(output)
          base, target     = output['url'].split('-')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Digitalprice::Market::NAME
          ticker.last      = NumericHelper.to_d(output['priceLast'])
          ticker.volume    = NumericHelper.to_d(output['volumeQuote'])
          ticker.bid       = NumericHelper.to_d(output['bidHigh'])
          ticker.ask       = NumericHelper.to_d(output['askLow'])
          ticker.low       = NumericHelper.to_d(output['priceLow'])
          ticker.high      = NumericHelper.to_d(output['priceHigh'])
          ticker.change    = NumericHelper.to_d(output['priceChange'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
