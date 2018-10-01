module Cryptoexchange::Exchanges
  module Bcoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(Bcoin::Market::API_URL)
          adapt_all(output)
        end

        def adapt_all(output)
          output['data'].map do |pair, data|
            base, target = pair.split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bcoin::Market::NAME
            )

            adapt(market_pair, data)
          end
        end

        def adapt(market_pair, data)
          Cryptoexchange::Models::Ticker.new(
            base: market_pair.base,
            target: market_pair.target,
            market: market_pair.market,
            ask: NumericHelper.to_d(data['lowestAsk'].to_f),
            bid: NumericHelper.to_d(data['highestBid'].to_f),
            last: NumericHelper.to_d(data['last'].to_f),
            high: NumericHelper.to_d(data['high24hr'].to_f),
            low: NumericHelper.to_d(data['low24Hr'].to_f),
            volume: NumericHelper.to_d(data['baseVolume'].to_f),
            timestamp: nil,
            payload: data
          )
        end
      end
    end
  end
end
