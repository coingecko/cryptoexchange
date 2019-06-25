module Cryptoexchange::Exchanges
  module Tdax
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
          "#{Cryptoexchange::Exchanges::Tdax::Market::API_URL}/marketcap/"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            base, target = pair.split('_')
            adapt(ticker, base, target)
          end
        end

        def adapt(output, base, target)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Tdax::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high24hr'])
          ticker.low       = NumericHelper.to_d(output['low24hr'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
