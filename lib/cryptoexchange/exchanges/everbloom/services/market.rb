module Cryptoexchange::Exchanges
  module Everbloom
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
          "#{Cryptoexchange::Exchanges::Everbloom::Market::API_URL}/markets"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base: pair['name'],
              target: 'ETH',
              market: Everbloom::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Everbloom::Market::NAME
          ticker.last      = NumericHelper.divide(NumericHelper.to_d(output['last'].to_f), 1e18)
          ticker.high      = NumericHelper.divide(NumericHelper.to_d(output['high'].to_f), 1e18)
          ticker.low       = NumericHelper.divide(NumericHelper.to_d(output['low'].to_f), 1e18)
          ticker.bid       = NumericHelper.divide(NumericHelper.to_d(output['highestBid'].to_f), 1e18)
          ticker.ask       = NumericHelper.divide(NumericHelper.to_d(output['lowestAsk'].to_f), 1e18)
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(output['volume'].to_f), 1e18)
          ticker.timestamp = output['updatedAt']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
