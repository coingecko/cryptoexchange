module Cryptoexchange::Exchanges
  module Secondbtc
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
          "#{Cryptoexchange::Exchanges::Secondbtc::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            next unless ticker['isFrozen'] == '0'
            adapt(pair, ticker)
          end.compact
        end

        def adapt(pair, output)
          ticker         = Cryptoexchange::Models::Ticker.new
          target, base   = pair.split('_')
          ticker.base    = base
          ticker.target  = target
          ticker.market  = Secondbtc::Market::NAME
          ticker.last    = NumericHelper.to_d(output['last'])
          ticker.ask     = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid     = NumericHelper.to_d(output['highestBid'])
          ticker.volume  = NumericHelper.to_d(output['quoteVolume'])
          ticker.high    = NumericHelper.to_d(output['high24hr'])
          ticker.low     = NumericHelper.to_d(output['low24hr'])
          ticker.change  = NumericHelper.to_d(output['percentChange'])
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
