module Cryptoexchange::Exchanges
  module Maplechange
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
          "#{Cryptoexchange::Exchanges::Maplechange::Market::API_URL}/tickers.do"
        end


        def adapt_all(output)
          output.map do |ticker|
            timestamp = ticker[1]['at']
            symbol = ticker[0].upcase
            base, target = symbol.split(/(BTC$)+|(ETH$)+|(WAE$)+|(LTC$)+|(XGOX$)+|(EGEM$)+|(XSH$)+/)
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Maplechange::Market::NAME
            )
            adapt(ticker, market_pair, timestamp)
          end
        end

        def adapt(output, market_pair, timestamp)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Maplechange::Market::NAME
          ticker.ask       = NumericHelper.to_d(output[1]['ticker']['sell'])
          ticker.bid       = NumericHelper.to_d(output[1]['ticker']['buy'])
          ticker.last      = NumericHelper.to_d(output[1]['ticker']['last'])
          ticker.change    = NumericHelper.to_d(output[1]['ticker']['change'])
          ticker.high      = NumericHelper.to_d(output[1]['ticker']['high'])
          ticker.low       = NumericHelper.to_d(output[1]['ticker']['low'])
          ticker.volume    = NumericHelper.to_d(output[1]['ticker']['vol'])
          ticker.timestamp = NumericHelper.to_d(timestamp)
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
