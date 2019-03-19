module Cryptoexchange::Exchanges
  module Iqfinex
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
          "#{Cryptoexchange::Exchanges::Iqfinex::Market::API_URL}/v1/tickers"
        end

        def adapt_all(output)
          output['data'].map do |pair, ticker|
            adapt(pair, ticker)
          end
        end

        def adapt(pair, output)
          base, target     = pair.split(/(BTC$)+|(ETH$)+|(USDT$)+/)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Iqfinex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume24'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
