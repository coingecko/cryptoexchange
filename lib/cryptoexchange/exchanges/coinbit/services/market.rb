module Cryptoexchange::Exchanges
  module Coinbit
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
          "#{Cryptoexchange::Exchanges::Coinbit::Market::API_URL}"
        end

        def adapt_all(output)
          output.map do |pair|
            target, base = pair[0].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinbit::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinbit::Market::NAME
          ticker.last      = NumericHelper.to_d(output[1]['last'])
          ticker.bid       = NumericHelper.to_d(output[1]['highestBid'])
          ticker.ask       = NumericHelper.to_d(output[1]['lowestAsk'])
          ticker.high      = NumericHelper.to_d(output[1]['high24hr'])
          ticker.low       = NumericHelper.to_d(output[1]['low24hr'])
          ticker.volume    = NumericHelper.to_d(output[1]['baseVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
