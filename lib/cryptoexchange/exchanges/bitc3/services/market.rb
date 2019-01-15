module Cryptoexchange::Exchanges
  module Bitc3
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
          "#{Cryptoexchange::Exchanges::Bitc3::Market::API_URL}/iqtexQuote"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            adapt(pair, ticker)
          end
        end

        def adapt(pair, output)
          base, target     = pair.split('/')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Bitc3::Market::NAME
          ticker.last      = NumericHelper.to_d(output['latest'])
          ticker.high      = NumericHelper.to_d(output['high24hr'])
          ticker.low       = NumericHelper.to_d(output['low24hr'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
