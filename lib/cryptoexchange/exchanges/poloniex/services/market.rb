module Cryptoexchange::Exchanges
  module Poloniex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Poloniex::Market::API_URL}?command=returnTicker"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            # Target comes first in Poloniex ie. BTC-BCN
            # BTC cannot be a base in this pair
            target, base = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Poloniex::Market::NAME
                          )

            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Poloniex::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['highestBid'])
          ticker.ask       = NumericHelper.to_d(output['lowestAsk'])
          ticker.high      = NumericHelper.to_d(output['high24hr'])
          ticker.low       = NumericHelper.to_d(output['low24hr'])
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
