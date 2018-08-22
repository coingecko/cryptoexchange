module Cryptoexchange::Exchanges
  module Livecoin
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
          "#{Cryptoexchange::Exchanges::Livecoin::Market::API_URL}/exchange/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['symbol'].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Livecoin::Market::NAME
                          )

            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Livecoin::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['best_bid'])
          ticker.ask       = NumericHelper.to_d(output['best_ask'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
