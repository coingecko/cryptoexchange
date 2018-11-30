module Cryptoexchange::Exchanges
  module Blokmy
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
          "#{Cryptoexchange::Exchanges::Blokmy::Market::API_URL}/tickers.json"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            adapt(pair, ticker)
          end
        end

        def adapt(pair, output)
          base, target     = pair.split(/(BTC$)+|(MYR$)+/i)
          info             = output['ticker']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Blokmy::Market::NAME
          ticker.last      = NumericHelper.to_d(info['last'])
          ticker.high      = NumericHelper.to_d(info['high'])
          ticker.low       = NumericHelper.to_d(info['low'])
          ticker.bid       = NumericHelper.to_d(info['buy'])
          ticker.ask       = NumericHelper.to_d(info['sell'])
          ticker.volume    = NumericHelper.to_d(info['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
