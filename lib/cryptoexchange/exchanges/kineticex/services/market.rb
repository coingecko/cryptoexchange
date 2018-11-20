module Cryptoexchange::Exchanges
  module Kineticex
    module Services
      class Market < Cryptoexchange::Services::Market
        AUTO_INFLATE = true

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
          "#{Cryptoexchange::Exchanges::Kineticex::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            next if ticker['LastSellTimestamp'] < 0 || ticker['LastBuyTimestamp'] < 0
            adapt(ticker)
          end.compact
        end

        def adapt(output)
          base, target     = output['Symbol'].split(/(BTC$)+|(ETH$)+|(USD$)+|(LTC$)+|(DOGE$)+/)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Kineticex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['LastSellPrice'])
          ticker.bid       = NumericHelper.to_d(output['BestBid'])
          ticker.ask       = NumericHelper.to_d(output['BestAsk'])
          ticker.volume    = NumericHelper.to_d(output['DailyTradedTotalVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
