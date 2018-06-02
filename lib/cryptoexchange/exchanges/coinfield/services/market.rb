module Cryptoexchange::Exchanges
  module Coinfield
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
          "#{Cryptoexchange::Exchanges::Coinfield::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            separator = /(cad|usd|btc)\z/ =~ pair
            next if separator.nil?

            base    = pair[0..separator -1]
            target  = pair[separator..-1]
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinfield::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinfield::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ticker']['sell'])
          ticker.bid       = NumericHelper.to_d(output['ticker']['buy'])
          ticker.high      = NumericHelper.to_d(output['ticker']['high'])
          ticker.low       = NumericHelper.to_d(output['ticker']['low'])
          ticker.last      = NumericHelper.to_d(output['ticker']['last'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = output['at']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
