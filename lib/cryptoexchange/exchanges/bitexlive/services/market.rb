module Cryptoexchange::Exchanges
  module Bitexlive
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
          "#{Cryptoexchange::Exchanges::Bitexlive::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            next unless ticker['isFrozen'] == '0'
            adapt(pair, ticker)
          end.compact
        end

        def adapt(pair, output)
          target, base     = pair.split('_')
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Bitexlive::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high24hr'])
          ticker.low       = NumericHelper.to_d(output['low24hr'])
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
