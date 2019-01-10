module Cryptoexchange::Exchanges
  module Bitkop
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
          "#{Cryptoexchange::Exchanges::Bitkop::Market::API_URL}/tickerall"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair[1]['symbol'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bitkop::Market::NAME
            )
            adapt(market_pair, pair, output['time'])
          end
        end

        def adapt(market_pair, output, time)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitkop::Market::NAME
          ticker.last      = NumericHelper.to_d(output[1]['now'])
          ticker.high      = NumericHelper.to_d(output[1]['high'])
          ticker.low       = NumericHelper.to_d(output[1]['low'])
          ticker.bid       = NumericHelper.to_d(output[1]['bidPrice'])
          ticker.ask       = NumericHelper.to_d(output[1]['askPrice'])
          ticker.volume    = NumericHelper.to_d(output[1]['volume'])
          ticker.change    = NumericHelper.to_d(output[1]['priceChange'])
          ticker.timestamp = time
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
